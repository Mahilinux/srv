# /etc/profile.d/bash-history.sh:
bash_history:
  file.managed:
    - source: salt://bashrc/bash-history.sh
    - user: root
    - group: root
    - mode: 0644
  cmd.run:
    - name: source /etc/profile.d/bash-history.sh
