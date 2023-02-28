{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-service-file-directory-logs:
  file.directory:
    - name: '/var/log/{{ fluentbit.service.name }}/{{ fluentbit.config.filename }}'
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - recurse:
      - user
      - group

fluentbit-service-file-manage-service:
  file.managed:
    {%- if salt['test.provider']('service').startswith('systemd') %}
    - source: salt://{{ tplroot }}/files/templates/service.systemd.jinja
    - name: /etc/systemd/system/{{ fluentbit.service.name }}.service
    {%- elif salt['test.provider']('service') == 'upstart' %}
    - source: salt://{{ tplroot }}/files/templates/service.upstart.jinja
    - name: /etc/init/{{ fluentbit.service.name }}.conf
    {%- endif %}
    - mode: '0644'
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja
    - context:
        fluentbit: {{ fluentbit }}

{%- if fluentbit.service %}
fluentbit-service:
  service.running:
    - name: {{ fluentbit.service.name }}
    - enable: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - watch:
      - file: fluentbit-init-file
      - file: fluentbit-config*
{%- endif %}
