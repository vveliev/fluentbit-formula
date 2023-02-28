# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

include:
  - {{ sls_config_file }}

{%- if fluentbit.service.enabled %}
fluentbit-service-running-service-running:
  service.running:
    - name: {{ fluentbit.service.name }}
    - enable: True
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - watch:
      - sls: {{ sls_config_file }}
      # - file: fluentbit-service-file-manage-service
      # - file: fluentbit-config*
{%- endif %}