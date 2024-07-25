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

    end
  end
end
