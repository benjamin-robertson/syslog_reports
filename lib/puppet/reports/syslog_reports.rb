require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'
  File.open('/tmp/log.txt', 'a') { |f| 
    f.write('working now')
    f.close
  }

  def process

  end
  
end
