#!/bin/sh

apt-get update -y
apt-get install -y openssh-server python-virtualenv python-pip git ruby

cat > /go.sh <<EOF
#!/bin/sh

(cd /opt/git; git instaweb --httpd=webrick --port=80)
/usr/sbin/sshd -D
EOF

chmod +x /go.sh

mkdir -p /home/wware/.ssh /opt/git
(cd /opt/git; tar xfz ~wware/foo.git.tgz)
mv /opt/git/foo.git /opt/git/.git
chown -R wware:wware /opt/git

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFYkkqZ0hcxAgdTB1fI8AmvSujO/vUYn9UVYds7UkSXHWECZHk82j9ob2xwgJs4/zJ41sQOk5PaCGUXtO9BnfZMDNXbHZoyDBFMRpvfT6ASyZsGZ9mN/eqKopLG72IIgJh67a3wl+lhhyQ1hgj0NXmBQsSMq/m976cD5MKuDbjX1gpbLMYoV+e+Ww0UlboTT2Ean0+nHhifP/mJcKlHQV/U6IFvj2EulBBd73UxgugfWA0QOoLE9b4pEr7alQ5nxJc4NZNHiIurE6FX16gFbs31qHRnK4ZhIKflFn+N+TyCCCGt/eygiqzAKHAnQAqDoxgfQ/RCBUDEsIx1dN4QLG5" > /home/wware/.ssh/authorized_keys
