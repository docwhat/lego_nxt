#!/usr/bin/env rake

require "bundler/gem_tasks"
require "yard"
require "rspec/core/rake_task"

YARD::Rake::YardocTask.new
RSpec::Core::RakeTask.new(:spec)

namespace :usb do
  desc "Run RSpec code examples with a NXT connected via USB"
  task :spec do
    ENV['HAS_NXT'] = 'true'
    Rake::Task["spec"].invoke
  end
end

desc "Open a console with Lego_NXT"
task :console do
  require 'pry'
  require 'lego_nxt'
  ARGV.clear
  Pry.start
end
