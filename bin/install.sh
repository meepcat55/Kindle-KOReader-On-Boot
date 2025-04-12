#!/bin/sh
mntroot rw
cd /etc/init
echo """start on started lab126_gui
stop on stopping lab126_gui

pre-start script
  # important test to verify your script exists, else it could impact the boot of the kindle
  test -x /mnt/us/koreader/koreader.sh || { stop; exit 1; }
  ## sleep for hella long while waiting for ui
  ## Splash screen is about 90s and this script starts a bit after the splash screen, we NEED awesome and framework(lab126_gui) running coompletely before we start so wait 85s after lab126_gui starts so awesome loads too??
  ## Might be device dependent, choose between 75s and 85s
  /bin/sleep 85s
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
