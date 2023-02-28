# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo_install = tplroot ~ '.package.repo.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit without context %}


include:
  - {{ sls_repo_install }}

fluentbit-package-install-pkg-installed:
  pkg.installed:
    - name: {{ fluentbit.pkg.name }}
