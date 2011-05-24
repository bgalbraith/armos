#!/usr/bin/ruby
require 'rubygems'
require 'eventmachine'
require 'armos'

EM.run {
  port  = 9000
  host  = "67.207.129.182"
  armos = Armos.new(port, host)
  armos.start

  puts "Armos started on port #{port}"
}
