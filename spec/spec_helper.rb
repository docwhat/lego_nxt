# encoding: utf-8

require 'rspec/fire'

HAS_NXT = ENV['HAS_NXT'] == 'true'

unless HAS_NXT
  puts '**NOTE** Some tests are marked pending because you did not indicate you have a NXT brick.'
  puts '         To run all tests, plugin a NXT brick via USB, power it on, and set'
  puts "         the environment variable 'HAS_NXT' to 'true'."
end

def needs_nxt(&block)
  if HAS_NXT
    yield
  else
    pending 'This requires a NXT brick'
  end
end

if ENV['TRAVIS'] == 'true'
  require 'coveralls'
  Coveralls.wear!
else
  begin
    require 'simplecov'
    SimpleCov.start
  rescue LoadError
    puts 'Not loading simplecov'
  end
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.include(RSpec::Fire)

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

RSpec::Fire.configure do |config|
  config.verify_constant_names = true
end
