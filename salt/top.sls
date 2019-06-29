base:
  '*':
    - modules.disable-usb
    - modules.motd

  '*web*':
      - httpd
      - python
      - firewalld

