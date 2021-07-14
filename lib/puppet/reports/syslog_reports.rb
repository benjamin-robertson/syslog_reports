require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'
  f = File.open('/tmp/log.txt', 'a')
  f.write('testing puppet reports??')
  f.write('ohhhh yeah second line')
  
  def process

    f.write(self)
  end
  f.close
end
