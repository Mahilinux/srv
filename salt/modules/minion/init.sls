# This File is actively managed by Salt, manual changes are reverted

custom_minion:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://minion/minion
    - template: jinja