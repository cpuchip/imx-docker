#!/bin/bash
# This script will run into container

# source the common variables

. imx-6.1.55-2.2.0/env.sh

#

mkdir -p ${YOCTO_DIR}
cd ${YOCTO_DIR}

# Init

repo init \
    -u ${REMOTE} \
    -b ${BRANCH} \
    -m ${MANIFEST}

repo sync -j`nproc`

# source the yocto env

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source sources/meta-matter/tools/imx-matter-setup.sh build_${DISTRO}

# Build

bitbake ${IMAGES}
#bitbake ${IMAGES} -c populate_sdk
