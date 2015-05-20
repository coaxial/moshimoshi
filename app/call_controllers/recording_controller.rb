# encoding: utf-8

class RecordingController < Adhearsion::CallController
  def run
    logger.info "Recording requested"
    start_recording
  end

  def start_recording
    say "Now recording"
    play_audio "file:///usr/share/assets/beep.wav"
    record async: true, start_beep: true do |event|
      logger.info "Recording saved to #{event.recording.uri}"
    end
  end
end
