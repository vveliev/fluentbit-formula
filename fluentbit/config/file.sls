# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}
{%- from tplroot ~ "/libs/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

fluentbit-config-file-file-managed:
  file.managed:
    - name: {{ fluentbit.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='fluentbit-config-file-file-managed'
                 )
              }}
    - mode: "0644"
    - user: root
    - group: {{ fluentbit.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        fluentbit: {{ fluentbit | json }}
