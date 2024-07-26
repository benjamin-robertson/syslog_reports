# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`syslog_reports`](#syslog_reports): Sets up native syslog report processor for Puppet Master, compilers and replica.

## Classes

### <a name="syslog_reports"></a>`syslog_reports`

Sets up native syslog report processor for Puppet Master, compilers and replica.

#### Parameters

The following parameters are available in the `syslog_reports` class:

* [`syslog_server`](#-syslog_reports--syslog_server)
* [`enabled`](#-syslog_reports--enabled)
* [`manage_remote_syslog_logger_gem`](#-syslog_reports--manage_remote_syslog_logger_gem)
* [`report_status`](#-syslog_reports--report_status)

##### <a name="-syslog_reports--syslog_server"></a>`syslog_server`

Data type: `Stdlib::Host`

FQDN or IP address of target syslog server.

##### <a name="-syslog_reports--enabled"></a>`enabled`

Data type: `Boolean`

Enable the report processor.

Default value: `false`

##### <a name="-syslog_reports--manage_remote_syslog_logger_gem"></a>`manage_remote_syslog_logger_gem`

Data type: `Boolean`

Install the remote_syslog_logger gem.

Default value: `true`

##### <a name="-syslog_reports--report_status"></a>`report_status`

Data type: `Enum['failed','changed','unchanged']`

Level of reports to send to syslog. See readme.

Default value: `'changed'`
