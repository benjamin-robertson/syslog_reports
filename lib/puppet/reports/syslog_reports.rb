require 'puppet'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc "Send the corrective changes to syslog"

  desc "Setup logger"
  log = Syslog::Logger.new 'PuppetReports'

  def process
    log.info(self)
  end
end
