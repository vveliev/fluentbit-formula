# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import fluent_bit with context %}

{{ fluent_bit.pkg }}-pkg:
  pkg.installed:
    - name: {{ fluent_bit.pkg }}
