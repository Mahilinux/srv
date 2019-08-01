httpd:
 pkg.installed:
  - name: httpd
 service.running:
  - name: httpd
  - enable: True

/var/www/html/index.html:
 file.managed:
  - source: salt://modules/apache/index.html
  - user: root
  - group: root
  - mode: 644
