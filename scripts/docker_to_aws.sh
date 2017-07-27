#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# this script is used to ensure that the default docker xenial image has all
# the basic tooling that is available when running xenial in AWS.
#
# it also includes some scripts required in order to create virtual block devices
# which emulate the behaviour of mounting external EBS volumes in AWS
# -----------------------------------------------------------------------------

# create a 500M file in /opt/datapack.img
dd if=/dev/zero of=/opt/datapack.img bs=1M count=500
chmod 777 /opt/datapack.img

# expose /opt/datapack.img as virtual block device /dev/xvdf
# note: this command seems to fail intermittently, I can't figure out why?
while [ ! -f /opt/datapack.img ] ; do sleep 1; print 'waiting for img to be ready...'; done
ln $(losetup -o 32256 -f /opt/datapack.img -P --show) /dev/xvdf

# install apt packages which are available in the AWS AMI but missing in the docker image
apt-get update && apt-get install -y \
  sudo curl openssh-client \
  && rm -rf /var/lib/apt/lists/*

# create the 'ubuntu' user expected by AWS
useradd -ms /bin/bash ubuntu
