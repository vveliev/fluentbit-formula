fluent_bit:

  path: 
    logs: /logs
    config_file: /etc/fluentd/fluentd.conf
    config_dir: /etc/fluentd/conf.d
  plugins:
    - fluent-plugin-prometheus
    - fluent-plugin-remote_syslog
    - fluent-plugin-gelf-hs
  enabled: true
  configs:
    forward:
      settings:
        - directive: source
          attrs:
            - '@type': forward
            - port: 24224

    syslog:
      settings:
        - directive: worker
          directive_arg: '0'
          attrs:
            - nested_directives:
              - directive: source
                attrs:
                  - '@type': syslog
                  - port: 5140
                  - tag: syslog
                  - nested_directives:
                    - directive: transport
                      directive_arg: 'tcp'
                      attrs: []
                    - directive: parse
                      attrs:
                        - '@type': syslog
                        - message_format: auto          
              - directive: match
                directive_arg: 'syslog.**'
                attrs:
                  - '@type': copy
                  - deep_copy: 'true'
                  - nested_directives:
                      - directive: store
                        attrs:
                          - '@type': remote_syslog
                          - host: graylog.hostname
                          - port: 12514
                          - facility: local0
                          - severity: debug
                      - directive: store
                        attrs:
                          - '@type': gelf
                          - host: graylog.hostname
                          - port: 12201
                          - protocol: tcp
                          - nested_directives:
                              - directive: buffer
                                attrs:
                                  - flush_mode: interval
                                  - flush_interval: 1s   
                      - directive: store
                        attrs:
                          - '@type': file
                          - path: /logs/${tag[0]}/%Y%m%d/${tag[1]}/${tag[2]}
                          - append: 'true'             
                          - nested_directives:
                              - directive: buffer
                                directive_arg: 'tag,time'
                                attrs:
                                  - flush_mode: interval
                                  - flush_interval: 5s
    debugging:
      settings:
        - directive: worker
          directive_arg: '0'
          attrs:
            - nested_directives:
              - directive: source
                attrs:
                  - '@type': debug_agent
                  - bind: 127.0.0.1
                  - port: 24240
        - directive: match
          directive_arg: 'debug.**'
          attrs:
            - '@type': stdout

        - directive: match
          directive_arg: 'td.*.*'
          attrs:
            - '@type': copy
            - nested_directives:
                - directive: store
                  attrs:
                    - '@type': file
                    - path: /var/log/fluentd/td-failed_records
        - directive: match
          directive_arg: 'fluentd.*.*'
          attrs:
            - '@type': copy
            - nested_directives:
                - directive: store
                  attrs:
                    - '@type': file
                    - path: /var/log/fluentd/fluent-failed_records
    monitoring:
      settings:
        ## Prometheus metrics endpoint
        - directive: source
          attrs:
            - '@type': prometheus
            - port: 24231
            - metrics_path: /metrics
            - bind: 0.0.0.0
        ## Prometheus metrics counter
        - directive: source
          attrs:
            - '@type': prometheus_output_monitor
            - interval: 15
            - nested_directives:
                - directive: labels
                  attrs:
                    - tag: ${tag}
                    - hostname: ${hostname}

        - directive: filter
          directive_arg: 'syslog.*'
          attrs:
            - '@type': prometheus
            - nested_directives:
                - directive: metric
                  attrs:
                    - type: counter
                    - name: fluentd_input_status_num_records_total
                    - desc: The total number of incoming records
                    - nested_directives:
                      - directive: labels
                        attrs:
                          - tag: ${tag}
                          - hostname: ${hostname}
        - directive: match
          directive_arg: 'syslog.*'
          attrs:
            - '@type': copy
            - nested_directives:
                - directive: store
                  attrs:
                    - '@type': prometheus
                    - nested_directives:
                      - directive: metric
                        attrs:
                          - name: fluentd_output_status_num_records_total
                          - type: counter
                          - desc: The total number of outgoing records
                          - nested_directives:
                            - directive: labels
                              attrs:
                              - tag: ${tag}
                              - hostname: ${hostname}