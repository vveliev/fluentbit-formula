# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}

fluentbit-install-pkgrepo-managed-fluentd-repo:
  pkgrepo.managed:
    - humanname: Fluentbit Official
    - name: deb https://packages.fluentbit.io/debian/{{ fluentbit.repo.version }} {{ fluentbit.repo.version }} main
    - file: /etc/apt/sources.list.d/fluentbit.list
    - key_url: https://packages.fluentbit.io/fluentbit.key
    - clean_file: True
    # Order: 1 because we can't put a require_in on "pkg: salt-{master,minion}"
    # because we don't know if they are used.
    - order: 1
    - comments:
        - installed by salt


fluentbit-package-install-pkg-installed:
  pkg.installed:
    - name: {{ fluentbit.pkg.name }}
