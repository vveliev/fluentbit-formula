# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_repo_clean = tplroot ~ '.package.repo.clean' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

include:
  - {{ sls_package_repo_clean }}

fluentbit-package-repo-clean-repo-ubsent:
  file.absent:
    - name: /etc/apt/sources.list.d/fluentbit.list
    - require:
      - sls: {{ sls_config_clean }}
