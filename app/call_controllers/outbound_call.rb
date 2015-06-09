# encoding: utf-8

require_all 'app/call_controllers'
require 'matrioska/dial_with_apps'

class OutboundCallController < Adhearsion::CallController
  include Matrioska::DialWithApps

  def run
    answer
    extract_dialled_number
    invoke CostController
    logger.info "Calling #{@dialled_number}..."
    dial_with_local_apps "sofia/gateway/voipms/#{@dialled_number}", {
      # FIXME Handle caller id to reflect actual caller's cid
      from: "Test 15145551234",
      # The path to the file is the path on the FreeSWITCH machine.
      ringback: "file:///usr/share/assets/us_ringback_tone.mp3"
    } do |runner, dial|
      # Records a call, uploads it to S3 and emails the link
      runner.map_app '*7' do
        record_call_via_controller dial
      end
    end
    logger.info "Call to #{@dialled_number} ended."
    say 'The other party hung up. Goodbye.'
    hangup
  end

  def extract_dialled_number
    number = call.to.match(/(\d*)@.*/)[1]
    @dialled_number = number.empty? ? 'no digits' : number
  end

  def record_call_via_controller(dial)
    blocker = Celluloid::Condition.new
    dial.split main: RecordingController, others: SilentHoldController, main_callback: ->(call) { blocker.broadcast }
    blocker.wait
  end
end
