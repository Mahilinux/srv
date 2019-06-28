implement_bind:
  pkg.installed:
    - name: resolvconf

resolv_conf:
  file.managed:
    - name: /etc/resolvconf/resolv.conf.d/base
    - source: salt://modules/ubuntu/resolv.conf
