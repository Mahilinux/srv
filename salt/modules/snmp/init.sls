# created by Mahesh

{% import_yaml "snmp/map.yaml" as osmap %}
{% set snmp = salt['grains.filter_by'](osmap) %}

# install snmpd package
Install_SNMP:
  pkg.installed:
    - pkgs:
      - {{snmp.pkg}}
      - {{snmp.pkgutils}}


# snmpd.conf from salt-master
snmp_conf:
  file.managed:
    - name: {{snmp.config}}
    - source: {{snmp.source}}
    - user: root
    - group: root
    - mode: 644


# Restart SNMPD Service
start_service:
  service.running:
    - name: {{snmp.service}}
    - enable: True

# Create SNMPV3 User
#snmpd_user:
#rwusers:
#  - username: '<lxsnmpv3>'
#    authpassphrase: '<$1$fUkoicPG$IY2a.y5bptMo2yvzRkeXT0>'
#    view: all
#    authproto: 'SHA'
#    privproto: 'AES'
##    privpassphrase: '<$1$WTePaL6v$GH6rztznpBd9OBcESVkCH1>'