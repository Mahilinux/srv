{% import_yaml "mahesh-cylance/map.yaml" as osmajorrelease %}
{% set cylance = salt['grains.filter_by'](osmajorrelease,grain='osmajorrelease') %}

install_cylance:
  pkg.installed:
    - sources:
      - {{ cylance.name }}: {{ cylance.source }}


deploy_dir:
  file.directory:
    - mkdir: True
    - name: /opt/cylance

Configuration_File:
  file.managed:
    - name : /opt/cylance/config_defaults.txt
    - source: salt://cylance/files/config_defaults.txt
