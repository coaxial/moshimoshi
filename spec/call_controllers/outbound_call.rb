# encoding: utf-8

require 'spec_helper'
require 'call_controllers/outbound_call'

describe OutboundCall do

  describe '#dialled_number' do
    context 'when dialling to a number composed of digits' do

      let(:number_to_dial) { "5551231234" }
      let(:mock_call) { double 'Call', to: "sip:#{number_to_dial}@example.com" }
      subject { OutboundCall.new(mock_call) }

      it 'extracts the dialled number' do
        dialled_number = subject.instance_variable_get(:@dialled_number)
        expect(subject.extract_dialled_number).to eq(number_to_dial)
      end
    end

    context 'when dialling to a number not composed of digits' do

      let(:number_to_dial) { "bob_dylan" }
      let(:mock_call) { double 'Call', to: "sip:#{number_to_dial}@example.com" }
      subject { OutboundCall.new(mock_call) }

      it 'returns "no digits"' do
        dialled_number = subject.instance_variable_get(:@dialled_number)
        expect(subject.extract_dialled_number).to eq('no digits')
      end
    end
  end
end
