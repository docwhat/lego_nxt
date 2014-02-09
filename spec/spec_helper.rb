# encoding: utf-8
require 'rspec/fire'

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
  config.filter_run_excluding :needs_nxt unless 'true' == ENV['HAS_NXT']
  config.order = 'random'
end

# RSpec::Fire.configure do |config|
#   config.verify_constant_names = true
# end
