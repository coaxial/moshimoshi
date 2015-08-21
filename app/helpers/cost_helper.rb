# encoging: utf-8

module CostHelper
  include VoipmsRates::ControllerMethods

  def rate_in_cents(phone_number)
    cents_in_a_dollar = 100
    rate_in_dollars(phone_number) * cents_in_a_dollar
  end

  def rate_in_dollars(phone_number)
    get_rate_for(phone_number)
  end
end
