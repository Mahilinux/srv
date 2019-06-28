
{% if grains['kernel'] == 'Linux' %}
vm.swappiness:
  sysctl.present:
    - value: 50
    {% endif %}
