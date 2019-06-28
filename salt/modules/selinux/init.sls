/etc/selinux/config:
 file.managed:
  - source: salt://modules/selinux/config
  - user: root
  - group: root
  - mode: 644


