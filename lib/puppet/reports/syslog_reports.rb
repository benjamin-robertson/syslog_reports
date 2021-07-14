require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'
  File.open("log.txt", "w") { |f| f.write "#{Time.now} - User logged in\n" }

  def process

  end
  
end
