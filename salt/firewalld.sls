
install_firewalld:
  pkg.installed:
    - name: firewalld

firewalld_open_web:
  firewalld.present:
    - name: public
    - masquerade: False
    - ports:
      - 80/tcp
      - 443/tcp
      - services:
        - ssh
        - dhcpv6-client
