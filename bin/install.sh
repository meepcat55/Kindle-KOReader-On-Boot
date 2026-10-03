#!/bin/sh
mntroot rw
cd /etc/init
echo """start on started lab126_gui
stop on stopping lab126_gui

pre-start script
  # important test to verify your script exists, else it could impact the boot of the kindle
  test -x /mnt/us/koreader/koreader.sh || { stop; exit 1; }
  # Wait until splash screen disapears
  lipc-wait-event com.lab126.hal bootSplashCleanup
  # Wait a bit longer for awesome/framework to also be ready
  # Comment this out to directly launch to KOReader and only start framework on exit.
  /bin/sleep 20
end script

exec /mnt/us/koreader/koreader.sh --kual""" > kor.conf
cd /mnt/us
echo """#!/bin/sh

mntroot rw
cd /etc/init
rm kor.conf
mntroot ro
reboot""" > KOReader-autolaunch-remove.sh
mntroot ro
reboot
