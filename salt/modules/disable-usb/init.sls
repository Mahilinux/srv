disable_usb:
  file.managed:
    - name: /etc/modprobe.d/blacklist-usbstorage
    - contents: "blacklist usb-storage"
