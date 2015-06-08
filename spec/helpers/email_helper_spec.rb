# encording utf-8

require 'spec_helper'
require 'helpers/email_helper'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'

describe EmailHelper do
  let(:public_url) { 'https://moshimoshi-recordings-devel.s3-eu-west-1.amazonaws.com/dcf2045f09efbf2e4e9d65f4141f5dc8.wav' }
  let(:callee) { '5551231234' }
  let(:start_time) { Time.new(2000, 3, 25, 12, 45, 13) }
  let(:end_time) {  Time.new(2000, 3, 25, 12, 45, 13) + 125 * 60 }
  subject { EmailHelper }

  before do
    Timecop.freeze(end_time)
  end

  after do
    Timecop.return
  end

  it "integrates the recording's metadata into the email template" do
    recording_metadata = {
      to: callee,
      start_time: start_time,
      end_time: end_time
    }

    expect(subject.prepare_template(public_url, recording_metadata)).to include(public_url)
    expect(subject.prepare_template(public_url, recording_metadata)).to include(callee.to_i.to_s(:phone))
    expect(subject.prepare_template(public_url, recording_metadata)).to include('about 2 hours')
    expect(subject.prepare_template(public_url, recording_metadata)).to include('December 25th, 2000')
  end
end
