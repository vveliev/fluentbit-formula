# frozen_string_literal: true

# # Prepare platform "finger"
# platform_finger = system.platform[:finger].split('.').first.to_s

control 'fluentbit.package.repo' do
  title 'Verify the repo file'
  describe file('/etc/apt/sources.list.d/fluentbit.list') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end


control 'fluentbit.package.install' do
  title 'The required package should be installed'

  # Override by `platform_finger`
  package_name = 'fluent-bit'
  describe package(package_name) do
    it { should be_installed }
  end
end
