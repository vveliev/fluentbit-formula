# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit without context %}
{%- from tplroot ~ "/libs/libtofs.jinja" import files_switch with context %}

{%- set fluentbit_file = fluentbit | traverse("config:file") %}

include:
  - {{ sls_package_install }}

fluentbit-config-file-file-managed:
  file.managed:
    - name: {{ fluentbit_file }}
    - source: {{ files_switch(['fluentbit.yaml.jinja'],
                              lookup='fluentbit-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: {{ fluentbit.user }}
    - group: {{ fluentbit.group }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        fluentbit: {{ fluentbit | yaml }}
