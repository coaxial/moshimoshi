# encoding: utf-8

require 'spec_helper'

describe AwsHelper do

  let(:valid_path) { "/var/lib/freeswitch/recordings/3e2626ca-9315-4233-a981-5572c99b9e6e-4.wav" }  
  let(:invalid_paths) { ["", "invalid invalid"] }
  subject { AwsHelper }

  describe "#extract_extension" do
    context "with a valid path" do
      it "extracts the file's extension" do
        subject.instance_variable_set(:@path_to_file, valid_path)
        expect(subject.extract_extension).to eq(valid_path[-4..-1])
      end
    end

    context "with an invalid path" do
      it "returns `nil`" do
        result = []
        invalid_paths.each do |path|
          subject.instance_variable_set(:@path_to_file, path)
          result << subject.extract_extension
        end

        expect(result.all? { |row| row.nil? }).to eq(true)
      end
    end
  end
end
