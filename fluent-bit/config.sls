# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import fluent_bit with context %}

fluent-bit-config:
  file.managed:
    - name: /etc/fluent-bit/fluent-bit.conf
    - source: salt://fluent-bit/files/fluent-bit.conf.j2
    - mode: 644
    - makedirs: True
    - user: root
    - group: root
    - template: jinja
    - context:
      parsers: False

fluent-bit-parsers:
  file.managed:
    - name: /etc/fluent-bit/parsers.conf
    - source: salt://fluent-bit/files/fluent-bit.conf.j2
    - mode: 644
    - makedirs: True
    - user: root
    - group: root
    - template: jinja
    - context:
      parsers: True
