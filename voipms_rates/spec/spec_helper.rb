require 'adhearsion'
require 'voipms_rates'
require 'webmock/rspec'

# Require any .rb file in spec/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.color = true
  config.tty = true

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  # config.before(:each) do
  #   stub_request(:get, /https:\/\/www\.voip\.ms\/rates\/xmlapi\.php/).
  #    with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
  #    to_return(:status => 200, :body => "", :headers => {})
  # end
end

