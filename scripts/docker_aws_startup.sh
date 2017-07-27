#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# this startup script is automatially executed by /sbin/my_init when a
# container starts up
# -----------------------------------------------------------------------------

# the docker container MUST be started with the --privileged flag
if [ ! -e /dev/loop0 ]; then
  echo 'FATAL: docker container must be run using the --privileged flag'
  exit 1
fi

# expose /opt/volume.img as virtual block device /dev/xvdf
# note: this command seems to fail intermittently, I can't figure out why?

# creating more loop devices seems to fix the intermittent failure issue...
for i in {8..63}; do
  if [ -e /dev/loop$i ]; then continue; fi;
  mknod /dev/loop$i b 7 $i;
  chown --reference=/dev/loop0 /dev/loop$i;
  chmod --reference=/dev/loop0 /dev/loop$i;
done

# create a hard link from the attached /dev/loop* device to /dev/xvdf
ln $(losetup -f /opt/volume.img -P --show) /dev/xvdf

# mount all volumes specified in /etc/fstab
mount -a
