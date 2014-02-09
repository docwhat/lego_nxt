# encoding: utf-8

guard(
  'rspec',
  cmd: 'bundle exec rspec --color --format doc',
  all_after_pass: true,
  all_on_start: true
) do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end
