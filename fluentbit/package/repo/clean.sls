# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-package-repo-clean-repo-absent:
  file.absent:
    - name: {{ fluentbit.package.repo.file | default('/etc/yum.repos.d/' ~ fluentbit.package.repo.name ~ '.repo', true) }}
    - require:
      - pkg: fluentbit-package-clean-pkg-removed
