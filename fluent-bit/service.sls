# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

fluent_bit-service-configure-{{ bit.pkg }}:
  file.managed:
    - name: {{ bit.service.unit }}
    - source: salt://fluent-bit/files/service.{{ grains.init }}.conf.jinja
    - template: jinja

fluent_bit-service-configure_log_directory:
  file.directory:
    - name: '/var/log/td-agent-bit/'
    - makedirs: True
    - user: root
    - group: root
    - recurse:
      - user
      - group

fluent_bit-service-{{ bit.pkg }}:
  service.running:
    - name: {{ bit.pkg }}
    - enable: True
    - watch:
      - file: {{ bit.pkg }}-config
      - file: {{ bit.pkg }}-parsers
