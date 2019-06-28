
{% if salt['cmd.retcode']("grep '/bin/ksh' /etc/shells") != 0 %}
install_ksh:
  pkg.installed:
    - name: ksh
    {% endif %}
