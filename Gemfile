source 'https://rubygems.org'

gem 'adhearsion', '~> 2.6'

# Exercise care when updating the Punchblock major version, since Adhearsion
# apps sometimes make use of underlying features from the Punchblock API.
# Occasionally an update of Adhearsion will necessitate an update to
# Punchblock; in those cases update this line and test your app thoroughly.
gem 'punchblock', '~> 2.6'

# This is here by default due to deprecation of #ask and #menu.
# See http://adhearsion.com/docs/common_problems#toc_3 for details
gem 'adhearsion-asr'

# Fetches the per minute rate from voip.ms
gem 'voipms_rates', '~> 1.0'

# Handles in-call apps
gem 'matrioska', '~> 0.3'

# Allows `require_all '<dir>'`
gem 'require_all', '~> 1.3'

# To store recordings on S3
gem 'aws-sdk', '~> 2'

# To send emails
gem 'postmark', '~> 1.5'

# To compile HAML files
gem 'haml', '~> 4.0'
gem 'tilt', '~> 2.0'

# For Date and Time calculations
gem 'activesupport', '~> 4.2'
gem 'actionview'

#
# Check http://ahnhub.com for a list of plugins you can use in your app.
# To use them, simply add them here and run `bundle install`.
#

group :development, :test do
  gem 'rspec'
  gem 'timecop'
end

group :test do
  gem "codeclimate-test-reporter", require: false
end
