# encoding: utf-8

require "postmark"
require "tilt/haml"
require "active_support"
require "active_support/core_ext/integer/time" # provides #months
require "active_support/core_ext/date/calculations" # provides #advance for Time.now + 9.months
require "active_support/core_ext/numeric/conversions" # provides 5551231234.to_s(:phone)
require "active_support/core_ext/integer/inflections" # provides #ordinalize
require 'action_view'
include ActionView::Helpers::DateHelper # provides #distance_of_time_in_words

module EmailHelper
  def self.init
    @client = Postmark::ApiClient.new(ENV["POSTMARK_SERVER_TOKEN"])
  end

  def self.prepare_template(public_url, recording_metadata)
    # TODO: Test all this (☞ ﾟヮﾟ)☞
    @public_url = public_url
    @number_called_to = recording_metadata[:to].to_i.to_s(:phone)
    @recording_time = recording_metadata[:start_time].strftime("%k:%M")
    # FIXME: This is not i18n ready
    @recording_expiry_date = "#{recording_expiry_date.strftime("%B")} #{recording_expiry_date.strftime("%-d").to_i.ordinalize}, #{ recording_expiry_date.strftime("%Y")}"
    @recording_duration = recording_duration(recording_metadata[:start_time], recording_metadata[:end_time])

    Tilt::HamlTemplate.new('templates/send_recording.haml').render(self)
  end

  def self.send_email(public_url, recording_metadata)
    template = self.prepare_template(public_url, recording_metadata)
    self.init
    @client.deliver(
      from: ENV["POSTMARK_FROM"],
      to: ENV["MOSHIMOSHI_RECORDINGS_SENT_TO"],
      subject: "Your MoshiMoshi call to #{@number_called_to}",
      html_body: template
    )
  end

  def self.recording_expiry_date
    Time.now + 9.months
  end

  def self.recording_duration(from, to)
    ActionView::Helpers::DateHelper.distance_of_time_in_words(from, to)
  end
end
