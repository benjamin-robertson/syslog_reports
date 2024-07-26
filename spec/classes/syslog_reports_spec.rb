# frozen_string_literal: true

require 'spec_helper'

describe 'syslog_reports' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) do
        'service { \'pe-puppetserver\':
          ensure => running,
        }'
      end

      let(:params) do
        { 'enabled'       => true,
          'syslog_server' => 'dog.com' }
      end

      it { is_expected.to compile }

      contents = <<~TEXT
        ---
        enabled: true
        report_status: 'changed'
        syslog_server: 'dog.com'
      TEXT

      it { is_expected.to contain_file('/etc/puppetlabs/puppet/syslog_reports.yaml') }
      it { is_expected.to contain_file('/etc/puppetlabs/puppet/syslog_reports.yaml').with_content(contents) }
      it { is_expected.to contain_file('/etc/puppetlabs/puppet/syslog_reports.yaml').with_owner('pe-puppet') }
      it { is_expected.to contain_file('/etc/puppetlabs/puppet/syslog_reports.yaml').with_group('pe-puppet') }
      it { is_expected.to contain_file('/etc/puppetlabs/puppet/syslog_reports.yaml').with_mode('0640') }

      it { is_expected.to contain_package('remote_syslog_logger_gem').with_provider('puppetserver_gem') }

      it { is_expected.to contain_ini_subsetting('Update puppet.conf to include syslog_reports').with_subsetting('syslog_reports') }
      it { is_expected.to contain_ini_subsetting('Update puppet.conf to include syslog_reports').with_setting('reports') }
      it { is_expected.to contain_ini_subsetting('Update puppet.conf to include syslog_reports').with_section('master') }
      it { is_expected.to contain_ini_subsetting('Update puppet.conf to include syslog_reports').with_path('/etc/puppetlabs/puppet/puppet.conf') }
    end
  end
end
