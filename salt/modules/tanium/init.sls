# deploy tanium service
{% set is_installed = salt['service.available']('taniumclient') or salt['service.available']('TaniumClient') %}
{% if is_installed == False %}

{%- set redhat_version = '6.0.314.1442-1' %}
{%- set debian_version = '6.0.314.1442-debian6' %}
{%- set ubuntu_version = '6.0.314.1442-ubuntu10' %}
{%- set suse_version = '6.0.314.1442-1.sle11' %}
{%- set service_name = 'taniumclient' %}

{%- if grains['os_family'] == 'RedHat' %}

{%- if grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == 6 %}
{%- set file_name = 'TaniumClient-6.0.314.1579-1.rhe6.x86_64.rpm' %}
{%- set service_name = 'TaniumClient' %}

{%- elif grains['osmajorrelease'] == '7' or grains['osmajorrelease'] == 7 %}
{%- set file_name = 'TaniumClient-' + redhat_version + '.rhe7.x86_64.rpm' %}
{%- endif %}

{%- elif grains['os_family'] == 'Suse' %}
{% set file_name = 'TaniumClient-' + suse_version + '.x86_64.rpm' %}

{%- elif grains['os'] == 'Debian' %}
{%- set file_name = 'taniumclient-' + debian_version + '_amd64.deb' %}

{%- elif grains['os'] == 'Ubuntu' %}
{%- set file_name = 'taniumclient_' + ubuntu_version + '_amd64.deb' %}

{%- endif %}

push_pkg:
  file.managed:
    - name: /tmp/{{ file_name }}
    - source: salt://tanium/files/{{ file_name }}

install_tanium:
  cmd.run:
    - require:
      - push_pkg
{%- if grains['os_family'] == 'RedHat' %}
{%- if grains['osmajorrelease'] == 6 or grains['osmajorrelease'] == '6' %}
    - name: 'rpm -U /tmp/{{ file_name }}'
{%- set service_name = 'TaniumClient' %}
{%- elif grains['osmajorrelease'] == 7 or grains['osmajorrelease'] == '7' %}
    - name: 'rpm -U /tmp/{{ file_name }}'
{%- endif %}
{%- elif grains['os_family'] == 'Suse' %}
    - name: 'rpm -U /tmp/{{ file_name }}'
{%- elif grains['os'] == 'Debian' %}
    - name: 'dpkg  -i /tmp/{{ file_name }}'
{%- elif grains['os'] == 'Ubuntu' %}
    - name: 'dpkg  -i /tmp/{{ file_name }}'
{%- else %}
    - name: 'echo Wrong O/S'

fail_state:
  test.fail_without_changes:
    - name: 'We couldn't match any O/S (RedHat/CentOS | Debian/Ubuntu | Suse)'
{%- endif %}

remove_file_name:
  file.absent:
    - name: /tmp/{{ file_name }}
    - require:
      - push_pkg

update_servername:
  file.replace:
    - name: /opt/Tanium/TaniumClient/TaniumClient.ini
    - pattern: '^ServerName=.*'
    - repl: ServerName=tanium.servicenow.com
    - append_if_not_found: True

update_port:
  file.replace:
    - name: /opt/Tanium/TaniumClient/TaniumClient.ini
    - pattern: ^ServerPort=.*
    - repl: ServerPort=17472
    - append_if_not_found: True

update_loglevel:
  file.replace:
    - name: /opt/Tanium/TaniumClient/TaniumClient.ini
    - pattern: '^LogVerbosityLevel=.*'
    - repl: LogVerbosityLevel=1
    - append_if_not_found: True

deploy_cert:
  file.managed:
    - name: /opt/Tanium/TaniumClient/tanium.pub
    - source: salt://tanium/files/tanium_prod.pub
    - mode: 600

restart_service:
  service.running:
    - name: {{ service_name }}
    - watch:
      - file: update_servername
      - file: update_port
      - file: update_loglevel
{%- else %}
already installed:
  test.succeed_without_changes:
    - name : Tanium Client installed already
{%- endif %}
