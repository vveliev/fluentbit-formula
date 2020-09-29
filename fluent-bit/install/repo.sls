{%- from slspath + '/map.jinja' import fluent_bit with context -%}
fluent_bit-repo:
  pkgrepo.managed:
    - humanname: Fluentbit Official
    - name: deb https://packages.fluentbit.io/debian/{{ fluent_bit.repo.version }} {{ fluent_bit.repo.version }} main
    - file: /etc/apt/sources.list.d/fluentbit.list
    - key_url: https://packages.fluentbit.io/fluentbit.key
    - clean_file: True