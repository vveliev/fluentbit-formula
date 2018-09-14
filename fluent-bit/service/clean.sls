# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as bit with context %}

fluent-bit-service-clean-service-dead:
  service.dead:
    - name: {{ bit.service.name }}
    - enable: False
