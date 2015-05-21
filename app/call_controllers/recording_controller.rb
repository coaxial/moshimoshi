# encoding: utf-8

require "helpers/aws_helper"

class RecordingController < Adhearsion::CallController
  include AwsHelper

  def run
    logger.info "Recording requested"
    say "Now recording"
    play_audio "file:///usr/share/assets/beep.wav" # This file is on the FreeSWITCH server
    record async: true, start_beep: true do |event|
      # The following is exectuted to process the recording once it has stopped
      path_to_file = event.recording.uri.match(/file:\/\/(.+)/)[1] || nil
      if path_to_file === nil
        message = "No path_to_file extracted from the recording's URI: #{event.recording}"
        logger.warn message
        raise message
      end

      public_url = AwsHelper.upload_to_s3(path_to_file, ENV["AWS_RECORDINGS_BUCKET"])
      logger.info "Recording saved at #{public_url}"

      File.delete(path_to_file) if public_url.empty?
      logger.warn "Couldn't save recording to S3, the file has been kept at #{path_to_file}" if public_url.empty?

      # Rename file √
      # Upload file to S3 √
      # Get link √
      # Delete original file √
      # Compose email
      # Send email
    end
  end
end
