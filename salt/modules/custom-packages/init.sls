install_vim:
  pkg.installed:
    - name: vim-enhanced

install_coreutils:
  pkg.installed:
    - name: coreutils

install_sysstat:
  pkg.installed:
    - name: sysstat

install_wget:
  pkg.installed:
    - name: wget

install_telnet:
  pkg.installed:
    - name: telnet

install_bind:
  pkg.installed:
    - name: bind-utils

config_resolv:
  file.managed:
    - name: /etc/resolv.conf
    - source: salt://modules/custom-packages/resolv.conf
    - user: root
    - group: root
    - mode: 644


  





