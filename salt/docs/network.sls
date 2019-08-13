linux:
  network:
    purge_hosts: true
    host:
# No need to define this one if purge_hosts is true
    hostname:
      address: 127.0.1.1
      names:
      - ${linux:network:fqdn}
      - ${linux:network:hostname}
    node1:
      address: 192.168.10.200
      names:
        - node2.domain.com
        - service2.domain.com
    node2:
      address: 192.168.10.201
      names:
        - node2.domain.com
        - service2.domain.com