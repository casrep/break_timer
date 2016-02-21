#!/usr/bin/env ruby

require 'libnotify'

def get_input
	input = Float(ARGV[0])
	input *= 60
	return input
rescue
	puts "SYNTAX: timer <TIME>"
	puts "TIME: Time in minutes."
	exit
end

def get_interval(input)
	interval = input / 4
	if interval >= 1
		interval = interval.ceil
	end
	return interval
end

def get_messagetime(timeleft)
	hours_f   = timeleft.to_f / 3600
	hours     = hours_f.floor
	remainder = hours_f - hours
	timeleft  = remainder * 3600
	minutes_f = timeleft / 60
	minutes   = minutes_f.floor
	remainder = minutes_f - minutes
	seconds_f = remainder * 60
	seconds   = seconds_f.floor
	return "#{"%02d" % hours.to_i}:#{"%02d" % minutes.to_i}:#{"%02d" % seconds.to_i}"
end

def popup(message="SAMPLE TEXT")
	puts message
	notification = {
	        :body    => "Break Timer",
	        :timeout => nil,
	        :urgency => :critical
	}
	Libnotify.show(notification) do |options|
		options.summary = message
	end
end

input    = get_input
interval = get_interval(input)
timeleft = input
popup("Timer started.")

loop do
	if timeleft > 0
		sleep interval
		timeleft -= interval
		if interval >= 30
			messagetime = get_messagetime(timeleft)
			popup("Time Remaining (H:M:S) -	#{messagetime}") unless timeleft == 0
		end
	else
		popup("Stand up!")
		exit
	end
end
