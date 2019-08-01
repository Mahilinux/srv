custom_sudoers:
  file.managed:
    - name: /etc/sudoers.d/saltsudo
    - source: salt://modules/sudoers/saltsudo
    - user: root
    - group: root
    - mode: 440
