# syslog_reports

A Puppet report processor to send Puppet reports via native syslog. Includes Puppet manifest to configure syslog report processor.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with syslog_reports](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with syslog_reports](#beginning-with-syslog_reports)
1. [Usage](#usage)
    * [Puppet Enterprise](#puppet-enterprise)
    * [Opensource Puppet](#opensource-puppet)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Syslog_reports includes a report processor which sends UDP syslog on port 514 to a specified syslog server.

Syslog messages are broken into the following Puppet report fields.
```
"[#{msg.time}]: #{hostname}: Level:#{msg.level} #{msg.source}: #{msg.message}"
```
See [Puppet::Util::log][1] documentation for information on Puppet report fields. 

## Setup

### Setup Requirements

Puppet report processors need to be configured on the master, replica and all compilers to capture all agent reports. 

### Beginning with syslog_reports

Syslog_reports has three reporting levels which are set via the 'report_status' parameter/option.

* **failed**: Only log Puppet reports which contain failures.
* **changed**: Only log Puppet reports which contain failures AND changes.
* **unchanged**: Log all Puppet reports. 

If unset, syslog_reports will default to 'changed'.

## Usage

### Puppet Enterprise

To setup syslog_report processor in Puppet Enterprise using the provided manifest, perform the following steps.

1. Include module within Puppetfile. Ensure code has deployed to all PE infrastructure servers.
2. Under "PE Infrastructure Agent" node group. Add the `syslog_reports` class.
3. Set the following parameters
   * enabled = true
   * report_status = desired value.
   * syslog_server = target syslog server.
4. Ensure Puppet has completed a run on each PE infrastructure host.
5. Puppet reports will now be sent to the syslog server.

### Opensource Puppet

1. Include module within Puppetfile. Ensure module is deployed to all OSP servers.
2. On each Puppet server perform the following.
   * Install the gem [`remote_syslog_logger`][3].
   * Under Puppet config directory (typically /etc/puppetlabs/puppet). Create a configuration file `syslog_reports.yaml`. Configure as required. Example below
   * Update puppet.conf to include syslog_reports. Under [master] section. Add syslog_reports to `reports` option. Use comma to separate entries. 
       * For example `reports = puppetdb,syslog_reports`
   * Restart Puppet server
3. Puppet reports will now be sent to the syslog server.

syslog_reports.yaml configuration file example
```
---
enabled: true
report_status: 'changed'
syslog_server: 'syslog.mycompany.example'
```

## Limitations

 - Presently only UDP syslog on port 514 is supported. If you require TCP let me know via a feature request issue on Github.
 - All log line are truncated to maximum of 1024 characters. This restriction comes from [RFC 3164 section 4.1][4].

## Development

If you find any issues with this module, please log them in the issues register of the GitHub project. [Issues][2]

Module was developed with PDK.

PR's glady accepted :)


[1]: https://www.puppet.com/docs/puppet/8/format_report#format_report-puppet-util-log
[2]: https://github.com/benjamin-robertson/syslog_reports/issues
[3]: https://rubygems.org/gems/remote_syslog_logger
[4]: https://tools.ietf.org/html/rfc3164#section-4.1