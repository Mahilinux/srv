linux:
  network:
  resolv:
    dns:
    - 8.8.4.4
    - 8.8.8.8
    domain: my.example.com
    search:
    - my.example.com
    - example.com
    options:
    - ndots: 5
    - timeout: 2
    - attempts: 2