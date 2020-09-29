{%- from slspath + '/map.jinja' import mongodb with context -%}
fluent_bit-repo:
  pkgrepo.managed:
    - humanname: Fluentbit Official
    - name: deb https://packages.fluentbit.io/debian/buster {{ mongodb.version_repo }} main
    - file: /etc/apt/sources.list.d/fluentbit.list
    - key_url: https://packages.fluentbit.io/fluentbit.key
    - clean_file: True