# @summary Sets up native syslog report processor for Puppet Master, compilers and replica
#
# A description of what this class does
#
# @example
#   include syslog_reports
class syslog_reports (
  Stdlib::Host                         $syslog_server,
  Boolean                              $enabled                         = false,
  Boolean                              $manage_remote_syslog_logger_gem = true,
  Enum['failed','changed','unchanged'] $report_status                   = 'changed',
) {
  if $manage_remote_syslog_logger_gem {
    # Install remove syslog logger gem
    package { 'remote_syslog_logger_gem':
      ensure   => present,
      name     => 'remote_syslog_logger',
      provider => 'puppetserver_gem',
    }
  }

  # Create settings file.
  file { "${settings::confdir}/syslog_reports.yaml":
    ensure  => 'file',
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0640',
    content => epp('syslog_reports/syslog_reports.yaml.epp', {
        'enabled'       => $enabled,
        'syslog_server' => $syslog_server,
        'report_status' => $report_status,
    }),
  }

  # Update puppet.conf to include syslog_report processor.
  ini_subsetting { 'Update puppet.conf to include syslog_reports':
    ensure               => present,
    path                 => "${settings::confdir}/puppet.conf",
    section              => 'master',
    setting              => 'reports',
    subsetting           => 'syslog_reports',
    subsetting_separator => ',',
    notify               => Service['pe-puppetserver'],
  }
}
