#!/bin/sh

(cd /opt/git; git instaweb --httpd=webrick --port=80)
/usr/sbin/sshd -D
