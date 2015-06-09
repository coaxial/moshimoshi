# encoding: utf-8

class CostController < Adhearsion::CallController

  include VoipmsRates::ControllerMethods

  def run
    @rate = get_rate_for(call.to) * 100
    say "This call will cost #{@rate} US cents per minute"
  end
end
