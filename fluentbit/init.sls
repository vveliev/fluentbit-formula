# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit without context %}
{%- set includes = [] %}
{%- set components = [
      "package",
      "config",
      "service",
    ] %}
{%- for component in components %}
{%-   if fluentbit | traverse(component ~ ":enabled", False) %}
{%-     do includes.append("." ~ component) %}
{%-   endif %}
{%- endfor %}
include: {{ includes }}
