{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-log_directory:
  file.directory:
    - name: '/var/log/{{ fluentbit.pkg }}/'
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - recurse:
      - user
      - group

fluentbit-init-file:
  file.managed:
    {%- if salt['test.provider']('service').startswith('systemd') %}
    - source: salt://fluent-bit/files/templates/service.systemd.jinja
    - name: /etc/systemd/system/td-agent-bit.service
    {%- elif salt['test.provider']('service') == 'upstart' %}
    - source: salt://fluent-bit/files/templates/service.upstart.jinja
    - name: /etc/init/fluentd.conf
    {%- endif %}
    - mode: '0644'
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja
    - context:
        user: {{ fluentbit.user }}
        group: {{ fluentbit.group }}



{%- if fluentbit.service %}
fluentbit-service:
  service.running:
    - name: {{ fluentbit.process_name }}
    - enable: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - watch:
      - file: fluentbit-init-file
      - file: fluentbit-config*
{%- endif %}