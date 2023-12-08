#!/bin/bash
# This script will run into container

# source the common variables

. imx-6.1.36-2.1.0/env.sh

#

if [ ! -d "$YOCTO_DIR" ]; then
    echo "Yocto project folder not existing !!! Create it."
    mkdir -p ${YOCTO_DIR}
else
    echo "Yocto folder ready !"
fi
cd ${YOCTO_DIR}

# Init

if [ ! -d .repo ]; then
    echo "Start to setup repo"
    repo init \
        -u ${REMOTE} \
        -b ${BRANCH} \
        -m ${MANIFEST}

    repo sync -j`nproc`
else
    echo "Found existing repo"
fi

# source the yocto env

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# Build
echo -e "\nbitbake ${IMAGES} $*\n"
bitbake ${IMAGES} $*