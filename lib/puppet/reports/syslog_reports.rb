require 'puppet'
require 'fileutils'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'

  def process
    File.open("/tmp/log.txt", "w") { |f| f.write "#{Time.now} - User logged in\n" }
    #file = File.opne('/tmp/report.txt', 'w')

    #if status == 'corrective'
    #  Syslog.log(Syslog::LOG_INFO, self)
    #end
    # logdest.info(self)
  end
end
