{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-service-file-directory-logs:
  file.directory:
    - name: '/var/log/{{ fluentbit.service.name }}/{{ fluentbit.service.name }}'
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
