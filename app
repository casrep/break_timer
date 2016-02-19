#!/usr/bin/env ruby

# require 'libnotify'

# notification = {
        # :body    => "Breaker",
        # :timeout => nil,
        # :urgency => :critical
	# }

print "Time to break: "
input = gets.chomp!

time = Time.now
#start = time.to_s
stand = time + input.to_i
#stand = stand.to_s
intervals = [5,10,15,20,25]

def popup(msg=nil,min="ERROR")
	message = ["Timer started.", "#{min} minutes left...", "Stand up!"]
	puts message[msg]
	#Libnotify.show(notification) do |options|
	#	options.summary = message[@msg]
	#end
end

def timeint(t=1)
	int = Time.now + t
	int.to_s
end

popup(0)
#Libnotify.show(notification) do |options|
#	options.summary = message[0]
#end

loop do
	time = time.to_s
	if time < stand
		#t1 = timeint()
		#t2 = timeint(3)
		#t3 = timeint(900)
		#t4 = timeint(1200)
		#t5 = timeint(1500)
		#case time
		#	when t1
		#		popup(1,intervals[4])
		#	when t2
		#		minutes = intervals[3]
		#		popup
		#	when t3
		#		minutes = intervals[2]
		#		puts message[1]
		#	when t4
		#		minutes = intervals[1]
		#		puts message[1]
		#	when t5
		#		minutes = intervals[0]
		#		puts message[1]
		#end
	elsif time >= stand
		popup(2)
		#Libnotify.show(notification) do |options|
		#	options.summary = message[2]
		#end
		exit
	end
end
