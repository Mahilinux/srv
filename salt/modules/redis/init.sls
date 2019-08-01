install_redis:
  pkg.installed:
    - name: redis

start_redis:
  service.running:
    - name: redis
    - enable: True

redis_conf:
  file.managed:
    - source: salt://redis/files/redis.conf
    - name: /etc/redis.conf
    - user: root
    - group: root
    - mode: '0644'
    - require:
        - pkg: redis
    - watch_in:
        - service: redis
