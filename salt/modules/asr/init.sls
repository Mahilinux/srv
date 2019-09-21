# deploy ASR client
{% set is_installed = salt['service.available']('vxagent') %}

{% if is_installed == False %}

        {%- if grains['os_family'] == 'RedHat' %}
                {%- if grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == 6 %}
                {%- set file_name = 'Microsoft-ASR_UA_9.27.0.0_RHEL6-64_GA_15Jul2019_Release.tar.gz' %}
                {%- elif grains['osmajorrelease'] == '7' or grains['osmajorrelease'] == 7 %}
                {%- set file_name = 'Microsoft-ASR_UA_9.27.0.0_RHEL7-64_GA_15Jul2019_Release.tar.gz' %}
                {%- endif %}

        {%- elif grains['os_family'] == 'Suse' %}
        {%- set file_name = 'Microsoft-ASR_UA_9.27.0.0_SLES12-64_GA_15Jul2019_Release.tar.gz' %}

        {%- elif grains['os'] == 'Ubuntu' %}
                {%- if grains['osmajorrelease'] == '14' or grains['osmajorrelease'] == 14 %}
                {%- set file_name = 'Microsoft-ASR_UA_9.27.0.0_UBUNTU-14.04-64_GA_15Jul2019_Release.tar.gz' %}
                {%- elif grains['osmajorrelease'] == '16' or grains['osmajorrelease'] == 16 %}
                {%- set file_name = 'Microsoft-ASR_UA_9.27.0.0_UBUNTU-16.04-64_GA_15Jul2019_Release.tar.gz' %}
                {%- endif %}
        {%- endif %}

copy_pkg:
  file.managed:
    - name: /tmp/{{ file_name }}
    - source: salt://asr/files/{{ file_name }}

copy_passphrase:
  file.managed:
    - name: /tmp/passphrase.txt
    - source: salt://asr/files/passphrase.txt

install_agent:
  cmd.run:
    - require:
      - copy_pkg
    - name: |
        cd /tmp ;
        {%- if grains['os'] == 'Ubuntu' %}
        tar xvf {{ file_name }}
        {%- elif grains['os'] != 'Ubuntu' %}
        tar -xvzf {{ file_name }}
        {%- endif %}
        ./install -r MS -v VmWare -q
        /usr/local/ASR/Vx/bin/UnifiedAgentConfigurator.sh -i 10.15.10.76 -P /tmp/passphrase.txt

{%- else %}
already installed:
  test.succeed_without_changes:
    - name : ASR mobilityservice installed already
{%- endif %}
