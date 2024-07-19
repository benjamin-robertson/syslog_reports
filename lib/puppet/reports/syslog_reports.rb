require 'puppet'
require 'yaml'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'

  def debug(msg, host)
    timestamp = Time.now.utc.iso8601
    f = File.open('/var/log/puppetlabs/puppetserver/reporting_servicenow.log', 'a')
    f.write("[#{timestamp}]: [#{host}]: #{msg}\n")
    f.close
  end

  

  def process
    if self.status != nil then
      status = self.status
    else
      status = 'undefined'
    end

    # Log the report if there are changes.
    if self.status == 'changed'
      logs.each do | log |
        debug(log, host)
      end
    end
  end
end
