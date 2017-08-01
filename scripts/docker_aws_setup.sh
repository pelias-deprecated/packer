#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# this script is used to ensure that the default docker xenial image has all
# the basic tooling that is available when running xenial in AWS.
#
# it also includes some scripts required in order to create virtual block devices
# which emulate the behaviour of mounting external EBS volumes in AWS
# -----------------------------------------------------------------------------

# the docker image MUST be created with the --privileged flag
if [ ! -e /dev/loop0 ]; then
  echo 'FATAL: docker container must be run using the --privileged flag'
  exit 1
fi

# install apt packages which are available in the AWS AMI but missing in the docker image
apt-get update && apt-get install -y \
  sudo \
  && rm -rf /var/lib/apt/lists/*

# create the 'ubuntu' user expected by AWS
useradd -ms /bin/bash ubuntu

# -----------------------------------------------------------------------------
# create virtual block devices inside the docker container
# -----------------------------------------------------------------------------

# create a 100M file in /opt/volume.img if one has not already been bind-mounted
if [ ! -f /opt/volume.img ]; then
  dd if=/dev/zero of=/opt/volume.img bs=500M count=1
  chmod 777 /opt/volume.img
fi

# expose /opt/volume.img as virtual block device /dev/xvdf
# note: this command seems to fail intermittently, I can't figure out why?

# creating more loop devices seems to fix the intermittent failure issue...
for i in {8..63}; do
  if [ -e /dev/loop$i ]; then rm /dev/loop$i; fi;
  mknod /dev/loop$i b 7 $i;
  chown --reference=/dev/loop0 /dev/loop$i;
  chmod --reference=/dev/loop0 /dev/loop$i;
done

# bind to an available loop device
LOOPDEV=$(losetup -f /opt/volume.img -P --show)
echo "using loop device: ${LOOPDEV}"

# create a hard link from the attached /dev/loop* device to /dev/xvdf
ln ${LOOPDEV} /dev/xvdf

# -----------------------------------------------------------------------------
# configure startup scripts
# -----------------------------------------------------------------------------

# set startup scripts as executable
chmod +x /etc/my_init.d/*
