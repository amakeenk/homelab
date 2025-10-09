#!/bin/bash -eu

share_name=$1

share_path="/NAS/$share_name"

mkdir $share_path
chown -R shareuser:shareuser $share_path
chmod 2775 $share_path

echo "$share_path 192.168.1.0/24(rw,async,all_squash,anonuid=1001,anongid=1002,no_subtree_check)" >> /etc/exports
exportfs -ra
exportfs

cat >> /etc/samba/smb.conf <<EOF
[$share_name]
    path = $share_path
    browseable = yes
    read only = no
    valid users = @shareuser
    force user = shareuser
    force group = shareuser
    create mask = 0664
    directory mask = 0775
    inherit permissions = yes
    guest ok = no
EOF
systemctl restart smb nmb
testparm -s
