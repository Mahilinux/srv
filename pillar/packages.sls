
pkg:
{% if grains['os_family'] == 'Debian' %}
  httpd: apache2
  git: git-core
{% elif grains['os_family'] == 'RedHat' %}
  httpd: httpd
  git: git
{% elif grains['os_family'] == 'Suse' %}
  httpd: apache2
  git: git
{% endif %}
