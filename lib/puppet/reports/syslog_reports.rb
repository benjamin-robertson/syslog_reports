require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'
  File.open('/tmp/log.txt', 'a') { |file| file.write('work now?')  }
  
  def process

  end
  
end
