# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- set sls_package_repo_clean = tplroot ~ '.package.repo.clean' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

include:
  - {{ sls_config_clean }}
  - {{ sls_package_repo_clean }}

fluentbit-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ fluentbit.package.name }}
    - require:
      - sls: {{ sls_config_clean }}
