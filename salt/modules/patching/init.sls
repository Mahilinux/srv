# State to manage patching of minions

{# Begin RedHat/CentOS #}
{% if grains['os_family'] == 'RedHat' %}

security_updates:
  cmd.run:
    - name: 'yum update -y'
yum_cleanup:
  cmd.run:
    - name: 'yum-complete-transaction'

{% endif %}
{# End RedHat/CentOS #}

{# Begin Ubuntu #}
{% if grains['os'] == 'Ubuntu' %}

install_upgrades:
  cmd.run:
    - name: 'apt-get update; sudo unattended-upgrades'

{% endif %}
{# End Ubuntu #}

{# Begin SUSE #}
{% if grains['os'] == 'Suse' %}

#all_updates:
#  cmd.run:
#    - name: 'zypper update --exclude=kernel* -y'

#security_updates:
#  cmd.run:
#    - name: 'zypper update --security --exclude=kernel* -y'

{% endif %}
{# End SUSE #}

{# Reboot system #}
reboot_system:
  module.run:
    - name: system.reboot
