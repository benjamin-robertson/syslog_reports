require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'
  f = File.open('/tmp/log.txt', 'a')
  
  def process
    f.write('testing puppet reports??')
    f.write('ohhhh yeah second line')
    f.write(self)
    #file = File.opne('/tmp/report.txt', 'w')

    #if status == 'corrective'
    #  Syslog.log(Syslog::LOG_INFO, self)
    #end
    # logdest.info(self)
  end
  f.close
end
