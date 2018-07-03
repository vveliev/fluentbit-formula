# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import fluent_bit with context %}

configure-{{ fluent_bit.pkg }}-service:
  file.managed:
    - name: {{ fluent_bit.service.conf }}
    - source: salt://fluent-bit/files/service.{{ grains.init }}.conf.j2
    - template: jinja

{{ fluent_bit.pkg }}-service:
  service.running:
    - name: {{ fluent_bit.service.name }}
    - enable: True
    - watch:
      - file: {{ fluent_bit.pkg }}-config
      - file: {{ fluent_bit.pkg }}-parsers
