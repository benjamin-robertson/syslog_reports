require 'puppet'
require 'yaml'
require 'syslog/logger'

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Send the corrective changes to syslog'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'

  def debug(msg)
    timestamp = Time.now.utc.iso8601
    f = File.open('/var/log/puppetlabs/puppetserver/reporting_servicenow.log', 'a')
    f.write("[#{timestamp}]: DEBUG: #{msg}\n")
    f.close
  end

  

  def process
    if self.status != nil then
      status = self.status
    else
      status = 'undefined'
    end

    # Next, let's do something if the status equals 'failed'.
    # Finally, dump the report object to YAML and post it using the API object:
    if self.status = 'changed'
      debug(self.to_yaml)
    end
  end
end
