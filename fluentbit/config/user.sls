{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo_install = tplroot ~ '.package.repo.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as fluentbit with context %}


fluent_bit-create-user:
  user.present:
    - name: {{ fluentbit.user }}
    - createhome: True
    - shell: /bin/bash

fluent_bit-create-group:
  group.present:
    - name: {{ fluentbit.group }}
    - addusers:
        - {{ fluentbit.user }}
    - system: True
