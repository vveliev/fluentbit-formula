# -*- coding: utf-8 -*-
# vim: ft=yaml
---
portage:
  sync_wait_one_day: true
fluent-bit:
  pkg:
    name: 'app-shells/bash'
  service:
    name: "{{ 'systemd-journald' if grains.init == 'systemd' else 'mtab' }}"
