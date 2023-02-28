# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit without context %}
include:
{%- if fluentbit | traverse("fluentbit:service:enabled", False) | to_bool %}
  - .service
  - .running
{%- else %}
  - .clean
{%- endif %}
