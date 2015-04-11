# encoding: utf-8

require 'call_controllers/cost'
class OutboundCallController < Adhearsion::CallController

  def run
    answer
    extract_dialled_number
    invoke CostController
    logger.info "Calling #{@dialled_number}..."
    # TODO
    # Handle caller id to reflect the real caller id
    dial "sofia/gateway/voipms/#{@dialled_number}",
      from: "Test 15144463438",
      ringback: "file:///usr/share/assets/us_ringback_tone.wav" # The path to the file is the path on the FreeSWITCH machine. Only WAV files seem to play.
    logger.info "Call to #{@dialled_number} ended."
    say 'The other party hung up. Goodbye.'
    hangup
  end

  def extract_dialled_number
    number = call.to.match(/(\d*)@.*/)[1]
    @dialled_number = number.empty? ? 'no digits' : number
  end
end
