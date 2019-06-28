
{% import_yaml 'redis/lookup.yaml' as osmap %}
{% set redis = salt['grains.filter_by'](osmap) %}
redis_install:
  pkg.latest:
    - pkgs:
      {% for pkg in redis.pkgs %}
      - {{pkg}}
      {% endfor %}

redis_service:
  service.running:
    - enable: True
    - name: {{redis.service}}
    - require:
      - pkg: redis_install
      
redis_conf:
  file.managed:
    - source: salt://redis/files/redis.conf.jinja
    - name: {{redis.conf}}
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - redis_bind: {{salt['pillar.get']('redis:bind')}}
    - redis_port: {{salt['pillar.get']('redis:port')}}
    - redis_dir: {{salt['pillar.get']('redis:root_dir')}}
    - require:
        - pkg: redis_install
    - watch_in:
        - service: redis_service

