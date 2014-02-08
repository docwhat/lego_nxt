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

desc "Open a console with Lego_NXT"
task :console do
  require 'pry'
  require 'lego_nxt'
  ARGV.clear
  puts "Welcome to the LegoNXT Ruby console!"
  puts "------------------------------------"
  Pry.start
end
