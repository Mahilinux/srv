salt_master_conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - names:
      - /etc/salt/master.d/master.conf:
        - source: salt://saltmaster/master.conf
      - /etc/salt/master.d/fileserver.conf:
        - source: salt://saltmaster/fileserver.conf