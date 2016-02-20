#!/usr/bin/env ruby

require 'libnotify'

def start_prompt
	print "Time to break (minutes): "
	i = Integer(gets)
	return i.to_f
rescue
	puts "Invalid character(s). Must be an integer."
	retry
end

def get_breaktime(i=0)
	i *= 60
	breaktime = Time.now + i
	return breaktime
end

def get_interval(i=0)
	interval     = i / 4
	if interval >= 1
		interval = interval.ceil
	end
	interval *= 60
	return interval
end

def get_timeleft(int=0,inp=0)
	inp *= 60
	timeleft = inp - int
	return timeleft
end

def popup(msg=4,t=0,b=Time.new)
	if t < 60
		u = "seconds"
	elsif t >= 60 && t < 3600
		t /= 60
		u = "minutes"
	elsif t >= 3600
		t /= 3600
		u = "hours"
	end
	b = b.strftime("%H:%M") || nil
	message = ["Timer started.\nBreak time is at #{b}.", "#{t.to_i} #{u} left...", "Stand up!", "ERR"]
	#puts message[msg]
	notification = {
	        :body    => "Breaker",
	        :timeout => nil,
	        :urgency => :critical
		}
	Libnotify.show(notification) do |options|
		options.summary = message[msg]
	end
end

def restart
	print "Restart? (y/n): "
	return gets.chomp!
end

input     = start_prompt
breaktime = get_breaktime(input)
interval  = get_interval(input)
timeleft  = get_timeleft(interval,input)
popup(0)

#puts "input = #{input}"
#puts "breaktime = #{breaktime}"
#puts "interval = #{interval}"
#puts "timeleft = #{timeleft}"

loop do
	time = Time.now
	unless time >= breaktime
		sleep interval
		#sleep 3
		popup(1,timeleft) unless timeleft == 0
		timeleft -= interval
	else
		popup(2)
		s = restart
		case s
		when "y" || "Y"
			input     = start_prompt
			breaktime = get_breaktime(input)
			interval  = get_interval(input)
			timeleft  = get_timeleft(interval,input)
			popup(0)
		when "n" || "N"
			puts "Goodbye!"
			exit
		else
			puts "Invalid command."
			s = restart
		end
	end
end
