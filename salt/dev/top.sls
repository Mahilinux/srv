dev:
  '*':
    - modules.disable-usb

  'os:Ubuntu':
    - match: grain
    - modules.motd
    - modules.ubuntu
