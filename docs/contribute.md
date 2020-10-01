# Development and contribution

## setting upo local docker env

### SaltStack

1. start docker containers `docker-compose up -d`
2. attach to salt-minion container `docker exec -it salt-fluentbit-formula bash`
3. Update example pillar data in `etc/saltstack/pillar/fluent-bit/init.sls`
4. run salt state sls `salt-call state.sls fluent-bit` 

## Troubleshooting fluentd

test messages:

`logger -n 10.161.72.218 --tcp -P 5140 "Test message"`

`echo ‘<14>_sourcehost_ messagetext’ | nc -v -w 0 10.161.72.218 5140`

https://superuser.com/questions/1229415/simple-way-to-generate-syslog-over-tcp/1229424