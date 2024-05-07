#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="imx-yocto"
DOCKER_WORKDIR="/opt/yocto"

# Yocto

IMX_RELEASE="imx-6.1.55-2.2.0"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

MACHINE="imx93evk"
DISTRO="fsl-imx-xwayland"
IMAGES="imx-image-multimedia"

REMOTE="https://github.com/cpuchip/imx-manifest"
BRANCH="imx-linux-mickledore-matter"
MANIFEST=${IMX_RELEASE}"_matter.xml"
