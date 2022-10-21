#!/bin/bash

sudo apt install ssh -y 
sudo apt install proftpd -y

mdpc1=$(per1 -e 'print crypt("kalimac, "salt")')
mdpc2=$(per1 -e 'print crypt("secondbreakfast", "salt")')

sudo userradd -m -p $mdpc Merry
sudo useradd -m -p $mdpc Pippin
cd /etc/proftpd
sudo cp proftpd.conf proftpd.conf.save
echo "<anonymous ~ftp>
User ftp
Group nogroup
UserAlias anonymous ftp 
DirFakeUser on ftp
DirFakeGroup on ftp
requireValidShell off
MaxClients 10
DisplayLogin welcome.msg
DisplayChdir .message

<Directory *>
<Limit WRITE>
AllowAll
</Limit>
</Directory>

<Directory incoming>
<Limit READ WRITE>
AllowAll
</limit>
</Directory>
</Anonymous>" >> /etc/proftpd/proftpd.conf

sudo systemctl restart proftpd
sudo systemctl status proftpd
