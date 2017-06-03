#!/usr/bin/ruby
# Ensure this file is placed in the same directory as snort_event_receiver.rb
require 'daemons'

Daemons.run('snort_event_retreiver.rb')
