# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import fluent_bit with context %}

configure-fluent-bit-service:
  file.managed:
    - name: {{ fluent_bit.service.conf }}
    - source: salt://fluent-bit/files/service.{{ grains.init }}.conf.j2
    - template: jinja

fluent-bit-service:
  service.running:
    - name: {{ fluent_bit.service.name }}
    - enable: True
