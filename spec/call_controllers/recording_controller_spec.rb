# encoding: utf-8

require 'spec_helper'
require 'call_controllers/recording_controller'

describe RecordingController do

  let(:caller_number) { "16665551234" }
  let(:callee_number) { "11235551234" }
  let(:mock_call) { double 'Call', :to => "sip:#{callee_number}@example.com", :from => "sip:#{caller_number}@example.com" }
  let(:valid_uri) { "file:///var/lib/freeswitch/recordings/3e2626ca-9315-4233-a981-5572c99b9e6e-4.wav" }
  let(:invalid_uris) { ["", "invalid invalid"] }
  subject { RecordingController.new(mock_call) }

  describe "#extract_path_from_uri" do
    context "with a valid uri" do
      it "extracts the file's path" do
        expect(subject.extract_path_from_uri(valid_uri)).to eq(valid_uri[7..-1])
      end
    end

    context "with an invalid URI" do
      it "returns `nil`" do
        result = []
        invalid_uris.each do |uri|
          result << subject.extract_path_from_uri(uri)
        end

        expect(result).to eq([nil, nil])
      end
    end
  end

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
      # let(:call) { Adhearsion::Call.new }
      # let(:controller) { RecordingController.new call }
      let(:mock_s3_upload) { double(AwsHelper).stub(:upload_to_s3) { "https://example.com/mock_recording.wav" } }
      let(:mock_file) { double File }

      it "deletes the recording from the disk" do
        pending "how to properly mock the call"
        subject.run
        expect(mock_file).to receive(:delete)
      end
    end

    context "when the recording wasn't saved in the cloud" do
      xit "doesn't delete the recording from the disk" do
      end
    end
  end
end
