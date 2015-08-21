# encoding: utf-8

require 'spec_helper'
require 'call_controllers/outbound_call'
require 'helpers/vars_helper'

describe OutboundCallController, :vcr do
  let(:number_to_dial) { "5551231234" }
  let(:mock_call) { double 'Call', to: "sip:#{number_to_dial}@example.com" }
  let(:cost_per_sec_in_cents) { 1.86 }
  subject { OutboundCallController.new(mock_call) }

  before(:example) do
    allow(subject).to receive(:answer)
    allow(subject).to receive(:say)
    allow(subject).to receive(:dial_callee)
    allow(subject).to receive(:hangup)
  end

  it "answers the call" do
    expect(subject).to receive(:answer).once
    subject.run
  end

  it "says the cost" do
    expect(subject).to receive(:say).with(/cost/)
    subject.run
  end

  it "rounds the cost" do
    expect(subject).to receive(:say).with(/#{cost_per_sec_in_cents}/)
    subject.run
  end

  it "logs the call being dialled and its cost" do
    allow(subject.logger).to receive(:info)
    expect(subject.logger).to receive(:info).with(/(#{number_to_dial}){1}.*(#{cost_per_sec_in_cents}){1}/)
    subject.run
  end

  it "logs the call being hung up" do
    allow(subject.logger).to receive(:info)
    expect(subject.logger).to receive(:info).with(/ended/)
    subject.run
  end

  it "informs the user the other party disconnected" do
    expect(subject).to receive("say").with(/hung up/)
    subject.run
  end

  # TODO: Missing test to verify that pressing apps_keymaps[:recorder] will record the call
end
