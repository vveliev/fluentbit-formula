# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import fluent_bit with context %}

{{ fluent_bit.pkg }}-config:
  file.managed:
    - name: /etc/{{ fluent_bit.pkg }}/{{ fluent_bit.pkg }}.conf
    - source: salt://fluent-bit/files/fluent-bit.conf.j2
    - mode: 644
    - makedirs: True
    - user: root
    - group: root
    - template: jinja
    - context:
      parsers: False

{{ fluent_bit.pkg }}-parsers:
  file.managed:
    - name: /etc/{{ fluent_bit.pkg }}/parsers.conf
    - source: salt://fluent-bit/files/fluent-bit.conf.j2
    - mode: 644
    - makedirs: True
    - user: root
    - group: root
    - template: jinja
    - context:
      parsers: True
