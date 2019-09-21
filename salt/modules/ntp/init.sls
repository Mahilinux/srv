# /srv/salt/ntp/init.sls: Install ntp service and set ntp servers
# created by Mahesh

{% import_yaml "ntp/map.yaml" as osmap %}
{% set ntp = salt['grains.filter_by'](osmap) %}

# install ntp service
Install_NTP:
  pkg.installed:
    - name: {{ntp.name}}

# ntp.conf from salt-master
ntp_conf:
  file.managed:
    - name: {{ntp.ntpfile}}
    - source: {{ntp.source_ntpfile}}
    - user: root
    - group: root
    - mode: 644

# Restart service
start_service:
  service.running:
    - name: {{ntp.service}}
    - enable: True