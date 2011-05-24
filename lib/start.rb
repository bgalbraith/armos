#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'

require 'eventmachine'
require 'armos'

EM.run {
  port  = 9000
  host  = "127.0.0.1"
  armos = Armos.new(port, host)
  armos.start

  puts "Armos started on port #{port}"
}
