# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as bit with context %}

include:
  - {{ sls_config_file }}

fluent-bit-service-running-service-running:
  service.running:
    - name: {{ bit.service.name }}
    - enable: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - watch:
      - sls: {{ sls_config_file }}
