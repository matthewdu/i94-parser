#!/usr/bin/env ruby

require 'pp'
require_relative 'parser'


if ARGV.length == 0 || ARGV[0] == "-h" || ARGV[0] == "--help"
  puts "Usage: #{$0} dates_file [--debug]"
  exit
end

pp get_year_duration(ARGV[0], ARGV.include?("--debug"))
