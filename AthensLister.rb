#!/usr/bin/env ruby
require 'logger'
require 'net/ssh'

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

# Create Servers Hash
# These are SCREEN session NAMES. 
# second part is the user and server used to SSH into
servers = {
			"snapshot" => "minecraft@a02.athensmc.com", 
			"rrr" => "modded@a02.athensmc.com", 
			"jtm" => "modded@a02.athensmc.com"
		  }

puts "There are... " + servers.count.to_s + " servers to send commands to."

servers.each do |servername, location|
	logger.info("Sending commands to #{location}")	
	@ssh_user = location[/[^@]+/]
	@ssh_host = location.split("@")[1]
	Net::SSH.start(@ssh_host, @ssh_user) do |session|
	 puts session.to_s + "Logged into #{@ssh_user}@#{@ssh_host}"
	  def send_to_remote(screenname, cmd)
		logger.debug("Sending Command to #{screenname}: " + cmd)
		"screen -S #{screenname} -p 0 -X stuff '#{cmd}\r'"
	  end
	 session.exec!(send_to_remote("#{servername}", "whitelist add #{new_member_username}"))
	 session.exec!(send_to_remote("#{servername}", "whitelist reload"))
	 session.exec!(send_to_remote("#{servername}", "say Please welcome #{new_member_username} when you see them!"))
	end
end

logger.info("AthensLister has finished whitelisting #{new_member_username}")