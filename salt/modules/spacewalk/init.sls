{% set file_name = salt['file.file_exists']('/etc/sysconfig/rhn/systemid') %}
{% if file_name == False %}

Repo_Push:
  file.managed:
    - name: /etc/yum.repos.d/spacewalk.repo
    {% if grains['osmajorrelease'] == 6 %}
    - source: salt://modules/spacewalk/spacewalk_el6.repo
    {% elif grains['osmajorrelease'] == 7 %}
    - source: salt://modules/spacewalk/spacewalk_el7.repo
    {% endif %}


Spacewalk_Install:
  pkg.installed:
    - pkgs:
      - spacewalk-client-repo
      - rhn-client-tools
      - rhnsd
      - m2crypto


Dependency:
  pkg.installed:
    - sources:
       - rhn-org-trusted-ssl-cert: salt://modules/spacewalk/rhn-org-trusted-ssl-cert-1.0-1.noarch.rpm

Registration:
  cmd.run:
    - skip_suggestions: True
    {% if grains['osmajorrelease'] == 6 %}
    - name: rhnreg_ks --serverUrl=https://10.15.10.236/XMLRPC --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --profilename=`hostname -f` --activationkey=1-Centos-6-AK
    {% elif grains['osmajorrelease'] == 7 %}
    - name: rhnreg_ks --serverUrl=https://10.15.10.236/XMLRPC --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --profilename=`hostname -f` --activationkey=1-Centos-7-AK
    {% endif %}

{% else %}
Already Installed:
  test.succeed_without_changes:
    - name: {{ grains['id'] }} is already registerd with Spacewalk
{% endif %}
