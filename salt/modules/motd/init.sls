custom_motd:
  file.managed:
    - name: /etc/motd
    - source: salt://modules/motd/conf
    - template: jinja
