require 'puppet'
require 'yaml'
require 'syslog/logger'

# config values
#
# enabled: boolean
#   default: false
# syslog_server: string
# report_status: Enum['failed','changed','unchanged']
#

Puppet::Reports.register_report(:syslog_reports) do
  desc 'Sends Puppet reports to syslog or file.'

  desc 'Setup logger'
  # logdest = Syslog::Logger.new 'PuppetReports'

  def debug(msg, host)
    timestamp = Time.now.utc.iso8601
    f = File.open('/var/log/puppetlabs/puppetserver/reporting_servicenow.log', 'a')
    f.write("[#{timestamp}]: #{host}: #{msg}\n")
    f.close
  end

  def process
    begin
      syslog_config_file = Puppet[:confdir] + '/syslog_reports.yaml'
      syslog_config = YAML.load_file(syslog_config_file)
    rescue
      Puppet.warn('Syslog reports: ERROR: failed to load config file. Ensure config file is valid YAML.')
      debug('Syslog reports: ERROR: failed to load config file. Ensure config file is valid YAML.', 'poodle')
      exit
    end

    # Set report_status
    report_status = case syslog_config['report_status']
                    when 'failed'
                      ['failed']
                    when 'changed'
                      ['failed', 'changed']
                    when 'unchanged'
                      ['failed', 'changed', 'unchanged']
                    else
                      ['failed', 'changed']
                    end

    # Quit if we are not enabled
    unless syslog_config['enabled']
      return '' # need to establish how to quit and not report.
    end

    if !self.status.nil?
      status = self.status
    else
      status = 'undefined'
    end

    # Log the report if there are changes.
    if report_status.include?(status)
      logs.each do |log|
        debug(log, host)
      end
    end
  end
end
