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

# Define the screen session name, then command to execute
execute("servername", "say hi")