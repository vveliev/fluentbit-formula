# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{%- set includes = [] %}
{%- set components = [
      "package",
      "config",
      "service",
    ] %}

{%- for component in components %}
{%-   do includes.append("." ~ component ~ ".clean") %}
{%- endfor %}

include: {{ includes }}