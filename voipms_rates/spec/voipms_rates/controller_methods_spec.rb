require 'spec_helper'

module VoipmsRates
  describe ControllerMethods do
    describe "mixed in to a CallController" do

      class TestController < Adhearsion::CallController
        include VoipmsRates::ControllerMethods
      end

      let(:mock_call) { double 'Call' }

      subject do
        TestController.new mock_call
      end

      describe '#get_rate_for' do
        
        let(:canadian_number) { '15145551234' }
        let(:us_number) { '12125551234' }
        let(:french_number) { '33953123456' }
        let(:invalid_number) { '9' }

        context 'when the premium rate is requested' do

          context 'with a valid number' do
            it 'returns the premium rate for Canada' do
              # This setting is toggled with `rake voipms_rates:canada_use_premium`
              Adhearsion.config[:voipms_rates].canada_use_premium = true
              VCR.use_cassette('canada_premium_rate') do
                expect(subject.get_rate_for(canadian_number)).to eq(0.009)
              end
              Adhearsion.config[:voipms_rates].canada_use_premium = false
            end

            it 'returns the premium rate for the US' do
              VCR.use_cassette('us_premium_rate') do
                expect(subject.get_rate_for(us_number)).to eq(0.01)
              end
            end

            it 'returns the premium rate for France' do
              # This setting is toggled with `rake voipms_rates:intl_use_premium`
              Adhearsion.config[:voipms_rates].intl_use_premium = true
              VCR.use_cassette('france_premium_rate') do
                expect(subject.get_rate_for(french_number)).to eq(0.0431)
              end
              Adhearsion.config[:voipms_rates].intl_use_premium = false
            end
          end

          context 'with an invalid number' do
            it 'returns "nil"' do
              VCR.use_cassette('invalid_number') do
                expect(subject.get_rate_for(invalid_number)).to eq(nil)
              end
            end
          end
        end

        context "when the premium rate isn't requested" do
          context 'with a valid number' do
            it 'returns the value rate' do
              VCR.use_cassette('canada_standard_rate') do
                expect(subject.get_rate_for(canadian_number)).to eq(0.0052)
              end
            end
          end

          context 'with an invalid number' do
            it 'returns "nil"' do
              VCR.use_cassette('invalid_number') do
                expect(subject.get_rate_for(invalid_number)).to eq(nil)
              end
            end
          end
        end
      end

    end
  end
end
