#!/usr/bin/env ruby
require 'logger'

module Logging
	def logger
		# Control the level of logging output to console / file
		# If silent is true, the log will NOT output Debug Messages
		# change silent to false to output debug level messages
		slient = false
		if slient == false
			Logging.logger.level = Logger::DEBUG
		else
			Logging.logger.level = Logger::INFO
		end

		# Format Logger Output to: [DEBUG] 04-30 22:58:36: MSG
		Logging.logger.formatter = proc do |severity, datetime, progname, msg|
		   "[#{severity}] #{datetime.strftime('%m-%d %H:%M:%S')}: #{msg}\n"
		end
		Logging.logger
	end

	def self.logger
		@logger ||= Logger.new(STDERR)
	end
end

module Execute
	def execute(screenname, cmd)
		logger.debug("Sending Command to #{screenname}: " + cmd)
		system("screen -S #{screenname} -p 0 -X stuff '#{cmd}\r'")
	end
end

include Logging
include Execute
logger.info("Hello World from AthensLister logger!")

# Did they pass something to the script to whitelist (username hopefully!)
if !ARGV[0]
	logger.fatal("Sorry you need to specify a username after calling the script!")
	logger.fatal("Example: ./AthensLister.rb USERNAME")
	abort
end

# Set the username to whitelist
new_member_username = ARGV[0]

# Create Servers Array
# These are SCREEN session NAMES. 
servers = ["servername", "snapshot", "rrr", "jtm"]

puts "There are... " + servers.count.to_s + " servers"

servers.each do |servername|
	execute("#{servername}", "say hi!")
	execute("#{servername}", "whitelist add #{new_member_username}")
	execute("#{servername}", "whitelist reload")
end