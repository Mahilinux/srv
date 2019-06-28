
{% for user in pillar['users'] %}
{{user}}:
  user.present:
    - uid: {{pillar['users'][user]}}
    {% endfor %}
