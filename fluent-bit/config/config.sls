# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

fluent_bit-config:
  file.managed:
    - name: /etc/{{ bit.pkg }}/{{ bit.pkg }}.conf
    - source: salt://fluent-bit/files/td-agent-bit.conf.jinja
    - mode: 644
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja

{%- for config_name,values in salt.pillar.get('fluent_bit:configs', {}).items()  %}
fluent_bit-add-config-{{ config_name }}:
  file.managed:
    - name: /etc/{{ bit.pkg }}/conf.d/lable-{{ config_name }}.conf
    - source: salt://fluent-bit/files/templates/fluent-config-template.conf
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja
    - makedirs: True  
    - context:
        settings: {{ values.settings }}
{% endfor %}
