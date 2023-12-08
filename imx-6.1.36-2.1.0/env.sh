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
#IMAGES="imx-image-core"
IMAGES="imx-image-multimedia"
#IMAGES="imx-image-full"

REMOTE="https://github.com/nxp-imx/imx-manifest"
BRANCH="imx-linux-mickledore"
MANIFEST=${IMX_RELEASE}".xml"

OPTIONS="-k"

#BitBake parameter      Description
# --runall=fetch
# -c fetch              # Fetches if the downloads state is not marked as done.
# -c clean"
# -c cleanall           # Cleans the entire component build directory. All the changes in the build directory are
                        # lost. The rootfs and state of the component are also cleared. The component is also
                        # removed from the download directory.
# -c deploy             # Deploys an image or component to the rootfs.
# -k                    # Continues building components even if a build break occurs.
# -c compile -f         # It is not recommended that the source code under the temporary directory is changed
                        # directly, but if it is, the Yocto Project might not rebuild it unless this option is used. Use
                        # this option to force a recompile after the image is deployed.
# -g"                   # Lists a dependency tree for an image or component.
# -DDD"                 # Turns on debug 3 levels deep. Each D adds another level of debug.
# -s, --show-versions"  # Shows the current and preferred versions of all recipes.