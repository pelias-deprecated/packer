#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# this is the teardown script for removing non-persistent operations executed
# in docker_aws_setup.sh
# -----------------------------------------------------------------------------

function unmount { if mount | grep $1 > /dev/null; then umount $1; fi }

# unmount volume(s)
unmount /dev/xvdf
