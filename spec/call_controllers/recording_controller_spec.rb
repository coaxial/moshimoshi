# encoding: utf-8

require 'spec_helper'
require 'call_controllers/recording_controller'

describe RecordingController do

  let(:caller_number) { "16665551234" }
  let(:callee_number) { "11235551234" }
  let(:mock_call) { double 'Call', :to => "sip:#{callee_number}@example.com", :from => "sip:#{caller_number}@example.com" }
  subject { RecordingController.new(mock_call) }

  describe "#extract_metadata" do
    before do
      Timecop.freeze(Time.local(1986, 7, 25, 0, 30, 0))
    end

    after do
      Timecop.return
    end

    it "extracts the relevant metadata" do
      expect(subject.extract_metadata).to eq({
        from: caller_number,
        to:   callee_number,
        time: Time.now
      })
    end
  end

  describe "#run" do
    context "when the recording has been successfully saved in the cloud" do
      # TODO
      let(:mock_s3_upload) { double(AwsHelper).stub(:upload_to_s3) { "https://example.com/mock_recording.wav" } }
      let(:mock_file) { double File }

      xit "deletes the recording from the disk" do
        pending "cannot test until I can properly mock a call"
        mock_call.stub(:write_and_await_response) { '#<Punchblock::Component::Output target_call_id=nil, target_mixer_name=nil, component_id=nil, source_uri=nil, domain=nil, transport=nil, timestamp=Sun, 07 Jun 2015 15:49:43 +0000, request_id="28e1552f-4abe-4d27-a400-b0dcff1b504d", headers={}, voice=nil, interrupt_on=nil, start_offset=nil, start_paused=nil, repeat_interval=nil, repeat_times=nil, max_time=nil, renderer=nil, render_documents=[#<Punchblock::Component::Output::Document target_call_id=nil, target_mixer_name=nil, component_id=nil, source_uri=nil, domain=nil, transport=nil, timestamp=Sun, 07 Jun 2015 15:49:43 +0000, url=nil, content_type="application/ssml+xml", value=<speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US"> <audio src="file:///usr/share/assets/beep.wav"/> speak>>]>' }
        subject.run
        expect(Source).to receive(:delete)
      end
    end

    context "when the recording wasn't saved in the cloud" do
      xit "doesn't delete the recording from the disk" do
      end
    end
  end
end
