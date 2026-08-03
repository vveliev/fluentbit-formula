# frozen_string_literal: true

control 'fluentbit.config.file' do
  title 'Verify the configuration file'
  describe file('/etc/fluentbit/fluent-bit.yaml') do
    it { should be_file }
    it { should be_owned_by 'fluentbit' }
    it { should be_grouped_into 'fluentbit' }
    its('mode') { should cmp '0644' }
    its('content') { should include 'service:' }
    its('content') { should include 'pipeline:' }
    its('content') { should include 'name: cpu' }
    its('content') { should include 'tag: my_cpu' }
    its('content') { should include 'match: my*cpu' }
    its('content') { should include 'name: stdout' }
  end
end
