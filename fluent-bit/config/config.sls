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
fluent_bit-config-add-{{ config_name }}:
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


fluent_bit-config-parsers:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.conf
    - source: salt://fluent-bit/files/parsers.conf.jinja
    - mode: 644
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja

fluent_bit-config-parsers-default-file:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.d/default_parsers.conf
    - source: salt://fluent-bit/files/templates/default_parsers.conf
    - mode: 644
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja

{%- for parser_name,values in salt.pillar.get('fluent_bit:parsers', {}).items()  %}
fluent_bit-config-parser-add-{{ parser_name }}:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.d/lable-{{ parser_name }}.conf
    - source: salt://fluent-bit/files/templates/fluent-config-template.conf
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja
<<<<<<< HEAD
    - makedirs: True  
    - context:
        settings: {{ values.settings }}
{% endfor %}
=======
    - makedirs: True
    - context:
        settings: {{ values.settings }}
{% endfor %}




fluent_bit-log_directory:
  file.directory:
    - name: '/var/log/{{ bit.pkg }}/'
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - recurse:
      - user
      - group

fluent_bit-init-file:
  file.managed:
    {%- if salt['test.provider']('service').startswith('systemd') %}
    - source: salt://fluent-bit/files/templates/service.systemd.jinja
    - name: /etc/systemd/system/td-agent-bit.service
    {%- elif salt['test.provider']('service') == 'upstart' %}
    - source: salt://fluent-bit/files/templates/service.upstart.jinja
    - name: /etc/init/fluentd.conf
    {%- endif %}
    - mode: '0644'
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja
    - context:
        user: {{ bit.user }}
        group: {{ bit.group }}
>>>>>>> daea4d0 (Fixed systemd service)
