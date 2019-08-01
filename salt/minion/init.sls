custom_minion:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://minion/minion
    - template: jinja

schedule_config:
  file.managed:
    - name: /etc/salt/minion.d/_schedule.conf
    - source: salt://minion/_schedule.conf
  cmd.run:
    - name: service salt-minion restart
