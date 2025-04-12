#!/bin/sh

mntroot rw
cd /etc/init
rm kor.conf
mntroot ro
reboot
