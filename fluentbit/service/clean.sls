# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-service-clean-service-dead:
  service.dead:
    - name: {{ fluentbit.service.name }}
    - enable: False
