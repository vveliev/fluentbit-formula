# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo_install = tplroot ~ '.package.repo.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-config-file:
  file.managed:
    - name: {{ fluentbit.config.path }}/{{ fluentbit.config.filename }}
    - source: salt://{{ tplroot }}/files/td-agent-bit.conf.jinja
    - mode: "0644"
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja

# {%- for config_name,values in salt.pillar.get('fluentbit:configs', {}).items()  %}
# fluentbit-config-add-{{ config_name }}:
#   file.managed:
#     - name: /etc/{{ fluentbit.pkg }}/conf.d/lable-{{ config_name }}.conf
#     - source: salt://fluent-bit/files/templates/fluent-config-template.conf
#     - user: {{ fluentbit.user }}
#     - group: {{ fluentbit.group }}
#     - template: jinja
#     - makedirs: True
#     - context:
#         settings: {{ values.settings }}
# {% endfor %}


# fluentbit-config-parsers:
#   file.managed:
#     - name: /etc/{{ fluentbit.pkg }}/parsers.conf
#     - source: salt://fluentbit/files/parsers.conf.jinja
#     - mode: 644
#     - makedirs: True
#     - user: {{ fluentbit.user }}
#     - group: {{ fluentbit.group }}
#     - template: jinja

<<<<<<< HEAD
fluentbit-config-parsers-default-file:
  file.managed:
    - name: /etc/{{ fluentbit.pkg }}/parsers.d/default_parsers.conf
    - source: salt://fluent-bit/files/templates/default_parsers.conf
    - mode: "0644"
    - makedirs: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - template: jinja
=======
# fluentbit-config-parsers-default-file:
#   file.managed:
#     - name: /etc/{{ fluentbit.pkg }}/parsers.d/default_parsers.conf
#     - source: salt://fluentbit/files/templates/default_parsers.conf
#     - mode: 644
#     - makedirs: True
#     - user: {{ fluentbit.user }}
#     - group: {{ fluentbit.group }}
#     - template: jinja
>>>>>>> cb2e4d1 (refactor: updating service configurations)

# {%- for parser_name,values in salt.pillar.get('fluentbit:parsers', {}).items()  %}
# fluentbit-config-parser-add-{{ parser_name }}:
#   file.managed:
#     - name: /etc/{{ fluentbit.pkg }}/parsers.d/lable-{{ parser_name }}.conf
#     - source: salt://fluentbit/files/templates/fluent-config-template.conf
#     - user: {{ fluentbit.user }}
#     - group: {{ fluentbit.group }}
#     - template: jinja
#     - makedirs: True
#     - context:
#         settings: {{ values.settings }}
# {% endfor %}




# fluentbit-log_directory:
#   file.directory:
#     - name: '/var/log/{{ fluentbit.pkg }}/'
#     - makedirs: True
#     - user: {{ fluentbit.user }}
#     - group: {{ fluentbit.group }}
#     - recurse:
#       - user
#       - group

