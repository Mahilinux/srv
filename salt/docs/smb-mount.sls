linux:
  storage:
    enabled: true
    mount:
      samba1:
      - path: /media/myuser/public/
      - device: //192.168.0.1/storage
      - file_system: cifs
      - options: guest,uid=myuser,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm