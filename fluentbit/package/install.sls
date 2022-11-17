# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as bit with context %}

fluent-bit-install-pkgrepo-managed-fluentd-repo:
  pkgrepo.managed:
    - humanname: Fluentbit Official
    - name: deb https://packages.fluentbit.io/debian/{{ bit.repo.version }} {{ bit.repo.version }} main
    - file: /etc/apt/sources.list.d/fluentbit.list
    - key_url: https://packages.fluentbit.io/fluentbit.key
    - clean_file: True
    # Order: 1 because we can't put a require_in on "pkg: salt-{master,minion}"
    # because we don't know if they are used.
    - order: 1
    - comments:
        - installed by salt


fluent-bit-package-install-pkg-installed:
  pkg.installed:
    - name: {{ bit.pkg.name }}
