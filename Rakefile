#!/usr/bin/env rake
# encoding: utf-8

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
