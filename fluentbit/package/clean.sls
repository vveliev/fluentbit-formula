# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

include:
  - {{ sls_config_clean }}

fluentbit-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ fluentbit.package.name }}
    - require:
      - sls: {{ sls_config_clean }}

# fluentbit-package-repo-remove:
#   pkgrepo.managed:
#     - humanname: Fluentbit Official
#     - name: deb https://packages.fluentbit.io/debian/{{ bit.repo.version }} {{ bit.repo.version }} main
#     - file: /etc/apt/sources.list.d/fluentbit.list
#     - key_url: https://packages.fluentbit.io/fluentbit.key
#     - clean_file: True
