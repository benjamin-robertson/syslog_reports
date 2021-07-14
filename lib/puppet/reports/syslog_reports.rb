require 'puppet'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'

  def process
    Syslog.log(Syslog::Log_puppet, self)
    # logdest.info(self)
  end
end
