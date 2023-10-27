# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}
{% set os_distrubition = grains['lsb_distrib_codename'] %}

fluentbit-repo-install-pkgrepo-managed-fluentd-official-repository:
  pkgrepo.managed:
    - humanname: Fluentbit Official Repository
    - name: deb https://packages.fluentbit.io/debian/{{ os_distrubition }} {{ os_distrubition }} main
    - file: /etc/apt/sources.list.d/fluentbit.list
    - key_url: https://packages.fluentbit.io/fluentbit.key
    - gpgcheck: 1
    - clean_file: True
    # Order: 3 because we can't put a require_in on "pkg: salt-{master,minion}"
    # because we don't know if they are used.
    - order: 3
    - comments:
        - installed by saltstack-formula/fluentbit-formula
