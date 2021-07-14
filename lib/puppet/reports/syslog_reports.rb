require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'
  File.open("/tmp/log.txt", "w") { |f| f.write "outside process\n" }

  def process
    File.open("/tmp/log2.txt", "w") { |f| f.write "inside process\n" }
  end
  
end
