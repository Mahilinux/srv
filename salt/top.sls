base:
  '*':
    - modules.disable-usb

  '*web*':
      - httpd
      - python

  'os:Ubuntu':
    - match: grain
    - modules.ubuntu

