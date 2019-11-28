# State to manage patching of minions

{# Begin RedHat/CentOS #}
{% if grains['os_family'] == 'RedHat' %}

yum_cleanup:
  cmd.run:
    - name: 'yum-complete-transaction'

security_updates:
  cmd.run:
    - name: 'yum update -y'

{% endif %}
{# End RedHat/CentOS #}

{# Begin Ubuntu #}
{% if grains['os'] == 'Ubuntu' %}

install_upgrades:
  cmd.run:
    - name: 'apt-get update; sudo apt-get dist-upgrade -y'

{% endif %}
{# End Ubuntu #}

{# Begin SUSE #}
{% if grains['os'] == 'Suse' %}

all_updates:
  cmd.run:
    - name: 'zypper update -y'

{% endif %}
{# End SUSE #}

{# Reboot system #}
reboot_system:
  module.run:
    - name: system.reboot
