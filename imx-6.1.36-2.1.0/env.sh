#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="imx-yocto"
DOCKER_WORKDIR="/opt/yocto"

# Yocto

IMX_RELEASE="imx-6.1.36-2.1.0"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

MACHINE="imx8ulp-lpddr4-evk"
DISTRO="fsl-imx-xwayland"
IMAGES="imx-image-core"
#IMAGES="imx-image-multimedia"
#IMAGES="imx-image-full"

REMOTE="https://github.com/nxp-imx/imx-manifest"
BRANCH="imx-linux-mickledore"
MANIFEST=${IMX_RELEASE}".xml"

OPTIONS="--runall=fetch"
