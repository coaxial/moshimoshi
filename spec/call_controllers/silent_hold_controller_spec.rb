# encoding: utf-8

require 'spec_helper'

describe SilentHoldController do

  let(:mock_call) { double 'Call', :to => '1112223333', :from => "2223334444" }
  let(:metadata) { {} }
  subject { SilentHoldController.new(mock_call, metadata) }

  it "should have empty metadata" do
    subject.metadata.should eq({})
  end

end
