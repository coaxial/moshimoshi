# encoding: utf-8

require "helpers/aws_helper"
require "helpers/email_helper"

class RecordingController < Adhearsion::CallController
  include AwsHelper
  include EmailHelper

  def run
    logger.info "Recording requested"
    extract_metadata
    play_audio "file:///usr/share/assets/beep.wav" # This file is on the FreeSWITCH server
    record async: true, start_beep: true do |event|
      # The following is exectuted to process the recording once it has stopped
      extract_path_from_uri(event.recording.uri)
      if @path_to_file.nil?
        message = "No path_to_file extracted from the recording's URI: #{event.recording}"
        logger.warn message
        raise message
      end

      public_url = AwsHelper.upload_to_s3(@path_to_file, ENV["AWS_RECORDINGS_BUCKET"])
      logger.info "Recording saved at #{public_url}"

      File.delete(@path_to_file) unless public_url.empty?
      logger.warn "Couldn't save recording to S3, the file has been kept at #{@path_to_file}" if public_url.empty?

      EmailHelper.send_recording public_url, @recording_metadata
    end
  end

  def extract_metadata
    sip_regex = /^sip:(.+)@.*$/i
    @recording_metadata = {
      from: call.from.match(sip_regex)[1],
      to:   call.to.match(sip_regex)[1],
      time: Time.now
    }
  end

  def extract_path_from_uri(uri)
    match = uri.match(/file:\/\/(.+)/)
    return @path_to_file = nil if match.nil?
    @path_to_file = uri.match(/file:\/\/(.+)/)[1]
  end
end
