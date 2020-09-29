# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

{{ bit.pkg }}-service:
  service.running:
    - name: {{ bit.pkg }}
    - enable: True
    - watch:
      - file: {{ bit.pkg }}-config
      - file: {{ bit.pkg }}-parsers
