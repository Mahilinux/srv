# Created by Mahesh

include:
  - modules.rsyslog

compress_azure_logs:
  file.managed:
    - name: /etc/logrotate.d/azure
    - source: salt://modules/logrotate/azure
    - user: root
    - group: root
    - mode: 644

compress_syslog_logs:
  file.managed:
    - name: /etc/logrotate.d/syslog
    - source: salt://modules/logrotate/syslog
    - user: root
    - group: root
    - mode: 644
