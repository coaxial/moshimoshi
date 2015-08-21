# encoding: utf-8

require_all 'app/call_controllers'
require_all 'app/helpers'
require 'matrioska/dial_with_apps'

class OutboundCallController < Adhearsion::CallController
  include Matrioska::DialWithApps
  include CostHelper
  include VarsHelper

  def run
    answer
    say "This call will cost #{call_cost} cents per minute"
    logger.info "Calling #{dialled_number} for #{call_cost} cents/min"
    dial_callee
    logger.info "Call to #{dialled_number} ended"
    say "The other party hung up. Goodbye!"
    hangup
  end

  def call_cost
    rate_in_cents(dialled_number).round(2)
  end

  def dialled_number
    # call.to comes from AHN and contains the SIP address to the callee
    number = call.to.match(/(\d*)@.*/)[1]
    # TODO: Maybe raise if we can't extract a number?
    extracted_number = number.empty? ? 'no digits' : number
    extracted_number
  end

  def dial_callee(caller_id=default_callerid)
    # Use Matrioska to listen for the recording trigger
    dial_with_local_apps "sofia/gateway/voipms/#{dialled_number}", {
      from: caller_id,
      ringback: ringback_tone_location
    } do |runner, dial|
      # Assign apps_keymaps[:recorder] as the DTMF trigger to start recording
      runner.map_app apps_keymaps[:recorder] do
        record_call_via_controller(dial)
      end
    end
  end

  def record_call_via_controller(dial)
    blocker = Celluloid::Condition.new
    dial.split main: RecordingController, others: SilentHoldController, main_callback: ->(call) { blocker.broadcast }
    blocker.wait
  end

end
