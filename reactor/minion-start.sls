
enforce_firewall_rules:
  local.state.sls:
    - tgt: {{data['id']}}
    - arg:
      - firewalld
