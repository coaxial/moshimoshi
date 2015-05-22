# encoding: utf-8

require "postmark"
require "tilt/haml"

module EmailHelper
  def self.init
    @client = Postmark::ApiClient.new(ENV["POSTMARK_SERVER_TOKEN"])
  end

  def self.send_recording(public_url, recording_metadata)
    # Making these variables accessible to the haml template
    @public_url = public_url
    @recording_metadata = recording_metadata
    send_recording_email_html = Tilt::HamlTemplate.new('templates/send_recording.haml').render(self)
    self.init
    @client.deliver(
      from: ENV["POSTMARK_FROM"],
      to: ENV["MOSHIMOSHI_RECORDINGS_SENT_TO"],
      subject: "Your call to #{recording_metadata[:to]}",
      html_body: send_recording_email_html
    )
  end
end
