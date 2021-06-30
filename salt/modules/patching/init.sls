# State to manage patching of minions
# Updated by Mahesh

{# Begin RedHat/CentOS #}

{% if grains['osmajorrelease'] == 6 or grains['osmajorrelease'] == 7 %}

yum-utils:
  pkg.installed

yum_cleanup:
  cmd.run:
    - name: yum-complete-transaction --cleanup-only
    - require:
      - pkg: yum-utils

{% endif %}

{% if grains['os'] == 'RedHat' %}

include:
  - modules.rhelsub

rhel_patching:
  cmd.run:
    - name: 'yum update -y'

{% endif %}


{% if grains['os'] == 'CentOS' %}

include:
  - modules.centos-repos

centos_patching:
  cmd.run:
    - name: 'yum update -y'

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

all_updates:
  cmd.run:
    - name: 'zypper update -y'

{% endif %}
{# End SUSE #}

{# Reboot system #}
reboot_system:
  cmd.run:
    - name: reboot
