
deploy_redis_servers:
  salt.state:
    - tgt: '*redis*'
    - sls:
        - redis

deploy_web_infra_servers:
  salt.state:
    - tgt: '*cweb*'
    - sls:
        - httpd
    - require:
        - salt: deploy_redis_servers

deploy_project_group:
  salt.function:
    - name: group.add
    - tgt: '*'
    - arg:
        - web-team
    - require:
        - salt: deploy_web_infra_servers
