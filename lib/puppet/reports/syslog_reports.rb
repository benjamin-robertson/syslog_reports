require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'

  def process
    f = File.open("/tmp/log.txt", "w") 
    f.write('testing puppet reports')
    f.close
    #file = File.opne('/tmp/report.txt', 'w')

    #if status == 'corrective'
    #  Syslog.log(Syslog::LOG_INFO, self)
    #end
    # logdest.info(self)
  end
end
