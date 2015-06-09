# encoding: utf-8

require 'spec_helper'

describe Source do
  let(:valid_uri) { 'file:///var/lib/freeswitch/recordings/3e2626ca-9315-4233-a981-5572c99b9e6e-4.wav' }
  let(:invalid_uris) { ["", "invalid invalid", "/foo/bar.baz"] }
  subject { Source.new '' }

  context "with a valid URI" do
    it "extracts the file's pathname" do
      subject.instance_variable_set(:@uri, valid_uri)
      expect(subject.pathname).to eq(valid_uri[7..-1])
    end
  end

  context "with an invalid URI" do
    it "returns `nil`" do
      result = []
      invalid_uris.each do |uri|
        subject.instance_variable_set(:@uri, uri)
        result << subject.pathname
      end

      expect(result.all? { |row| row.nil? }).to eq(true)
    end
  end
end
