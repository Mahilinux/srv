compress_syslog:
  file.managed:
    - name: /etc/logrotate.d/syslog
    - source: salt://modules/logrotate/syslog
    - user: root
    - group: root
