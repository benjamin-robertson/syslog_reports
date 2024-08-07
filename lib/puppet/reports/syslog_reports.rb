require 'puppet'
require 'yaml'
require 'remote_syslog_logger'
require 'logger'

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

  # def debug(msg, host)
  #   timestamp = Time.now.utc.iso8601
  #   f = File.open('/var/log/puppetlabs/puppetserver/reporting_servicenow.log', 'a')
  #   f.write("[#{timestamp}]: #{host}: #{msg}\n")
  #   f.close
  # end

  def syslog(msg, hostname, sys_logger)
    sys_logger.transmit("[#{msg.time}]: #{hostname}: Level:#{msg.level} #{msg.source}: #{msg.message}\n")
  end

  def process
    begin
      syslog_config_file = Puppet[:confdir] + '/syslog_reports.yaml'
      syslog_config = YAML.load_file(syslog_config_file)
    rescue
      Puppet.err('Syslog reports: ERROR: failed to load config file. Ensure config file is valid YAML.')
      return
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

    # # Quit if we are not enabled
    unless syslog_config['enabled']
      return
    end

    status = if !self.status.nil?
               self.status
             else
               'undefined'
             end

    # Open syslog connection
    begin
      sys_logger = RemoteSyslogLogger::UdpSender.new(syslog_config['syslog_server'], 514)
    rescue
      Puppet.err('Syslog reports: ERROR: Cannot resolve hostname for syslog server. ')
      return
    end

    # Log the report if there are changes.
    if report_status.include?(status)
      logs.each do |log|
        syslog(log, host, sys_logger)
      end
    end
    sys_logger.close
  end
end
