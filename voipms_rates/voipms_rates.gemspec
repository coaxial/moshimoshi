# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "voipms_rates/version"

Gem::Specification.new do |s|
  s.name        = "voipms_rates"
  s.version     = VoipmsRates::VERSION
  s.authors     = ["Coaxial"]
  s.email       = ["py@poujade.org"]
  s.homepage    = ""
  s.summary     = "Get voip.ms calling rates for given phone numbers."
  s.description = "Uses the voip.ms public API to fetch premium or value rates per minute for any phone number."

  s.rubyforge_project = "voipms_rates"

  # Use the following if using Git
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.files         = Dir.glob("{lib}/**/*") + %w( README.md Rakefile Gemfile)
  s.test_files    = Dir.glob("{spec}/**/*")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "adhearsion", ["~> 2.6"]
  s.add_runtime_dependency "activesupport", [">= 3.0.10"]
  s.add_runtime_dependency "rest-client", ["~> 1.8.0"]
  s.add_runtime_dependency "nokogiri", ["~> 1.6.6.2"]

  s.add_development_dependency "bundler", ["~> 1.0"]
  s.add_development_dependency "rspec", ["~> 2.5"]
  s.add_development_dependency "rake", [">= 0"]
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "webmock", ["~> 1.21.0"]
  s.add_development_dependency "vcr", ["~> 2.9.3"]
 end
