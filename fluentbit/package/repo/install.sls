# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}
{%- from tplroot ~ "/libs/format_kwargs.jinja" import format_kwargs with context %}

{%- if fluentbit.package.use_upstream_repo %}

grafana-package-repo-install-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(fluentbit.package.repo) }}

{%- endif %}
