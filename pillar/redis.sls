redis:
  root_dir: /var/lib/redis
  user: mahesh
  port: 6379
  bind: 0.0.0.0
  lookup:
    svc_state: stopped
    cfg_name: /etc/redis.conf
    pkg_name: redis-server
    svc_name: redis-server
