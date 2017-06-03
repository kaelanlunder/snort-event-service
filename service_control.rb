#!/usr/bin/ruby
# Ensure this file is placed in the same directory as snort_event_receiver.rb
# To start the service run the comand 'ruby serverice_control.rb start'
require 'daemons'

Daemons.run('snort_event_retreiver.rb')
