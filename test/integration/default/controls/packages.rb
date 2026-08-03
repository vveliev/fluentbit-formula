# frozen_string_literal: true

control 'fluentbit.package.repo' do
  title 'Verify the repo file'

  repo_file = if os.debian?
                '/etc/apt/sources.list.d/fluentbit.list'
              else
                '/etc/yum.repos.d/fluent-bit.repo'
              end

  describe file(repo_file) do
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
