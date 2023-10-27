# frozen_string_literal: true

# Prepare platform "finger"
# platform_finger = system.platform[:finger].split('.').first.to_s

control 'fluentbit.service.running' do
  title 'The service should be installed, enabled and running'

  # Override by `platform_finger`
  service_name = 'fluentbit'

  describe service(service_name) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
