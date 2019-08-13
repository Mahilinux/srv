{% set auditd = salt['grains.filter_by']({
'RedHat': { 'package': 'audit' },
'Debian': { 'package': 'auditd' },
}) %}