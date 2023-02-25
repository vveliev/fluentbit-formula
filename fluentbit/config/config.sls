# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo_install = tplroot ~ '.package.repo.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluent_bit-config:
  file.managed:
    - name: /etc/{{ fluentbit.pkg }}/{{ fluentbit.pkg }}.conf
    - source: salt://fluent-bit/files/td-agent-bit.conf.jinja
    - mode: 644
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja

{%- for config_name,values in salt.pillar.get('fluentbit:configs', {}).items()  %}
fluent_bit-config-add-{{ config_name }}:
  file.managed:
    - name: /etc/{{ fluentbit.pkg }}/conf.d/lable-{{ config_name }}.conf
    - source: salt://fluent-bit/files/templates/fluent-config-template.conf
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja
    - makedirs: True
    - context:
        settings: {{ values.settings }}
{% endfor %}


fluent_bit-config-parsers:
  file.managed:
    - name: /etc/{{ fluentbit.pkg }}/parsers.conf
    - source: salt://fluentbit/files/parsers.conf.jinja
    - mode: 644
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja

fluent_bit-config-parsers-default-file:
  file.managed:
    - name: /etc/{{ fluentbit.pkg }}/parsers.d/default_parsers.conf
    - source: salt://fluent-bit/files/templates/default_parsers.conf
    - mode: 644
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja

{%- for parser_name,values in salt.pillar.get('fluent_bit:parsers', {}).items()  %}
fluent_bit-config-parser-add-{{ parser_name }}:
  file.managed:
    - name: /etc/{{ fluentbit.pkg }}/parsers.d/lable-{{ parser_name }}.conf
    - source: salt://fluent-bit/files/templates/fluent-config-template.conf
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja
    - makedirs: True
    - context:
        settings: {{ values.settings }}
{% endfor %}




fluent_bit-log_directory:
  file.directory:
    - name: '/var/log/{{ fluentbit.pkg }}/'
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - recurse:
      - user
      - group

fluent_bit-init-file:
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
