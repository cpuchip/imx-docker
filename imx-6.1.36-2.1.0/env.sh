#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="imx-yocto"
DOCKER_WORKDIR="/opt/yocto"

# Yocto

IMX_RELEASE="imx-6.1.36-2.1.0"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

#MACHINE="imx8ulpevk"
MACHINE="imx8ulp-suntek"
DISTRO="fsl-imx-xwayland"
#DISTRO="fsl-imx-fb"
IMAGES="imx-image-core"    # An i.MX image with i.MX test applications to be used for
                            # Wayland backends. This image is used by our daily core testing.
#IMAGES="imx-image-multimedia"
#IMAGES="imx-image-full"
#IMAGES="core-image-minimal" # A small image that only allows a device to boot. poky
#IMAGES="core-image-base"   # A console-only image that fully supports the target device hardware.
#IMAGES="core-image-sato"   # An image with Sato, a mobile environment and visual
                            # style for mobile devices. The image supports a Sato
                            # theme and uses Pimlico applications. It contains a
                            # terminal, an editor and a file manager.
#IMAGES="fsl-image-machine-test"    # An FSL Community i.MX core image with console environment
                            # - no GUI interface.

REMOTE="https://github.com/nxp-imx/imx-manifest"
BRANCH="imx-linux-mickledore"
MANIFEST=${IMX_RELEASE}".xml"

#BitBake parameter      Description
# --runall=fetch
# -c fetch              # Fetches if the downloads state is not marked as done.
# -c clean
# -c cleanall           # Cleans the entire component build directory. All the changes in the build directory are
                        # lost. The rootfs and state of the component are also cleared. The component is also
                        # removed from the download directory.
# -c deploy             # Deploys an image or component to the rootfs.
# -k                    # Continues building components even if a build break occurs.
# -c compile -f         # It is not recommended that the source code under the temporary directory is changed
                        # directly, but if it is, the Yocto Project might not rebuild it unless this option is used. Use
                        # this option to force a recompile after the image is deployed.
# -g                    # Lists a dependency tree for an image or component.
# -DDD                  # Turns on debug 3 levels deep. Each D adds another level of debug.
# -s, --show-versions   # Shows the current and preferred versions of all recipes.

# <package name> -e | grep "^S="    # Find <package name> source path

# bitbake-layers show-recipes "<package_name>"
# ex. bitbake-layers show-recipes qt*

# Patching_the_source_for_a_recipe
# https://wiki.yoctoproject.org/wiki/TipsAndTricks/Patching_the_source_for_a_recipe
# 在yocto中使用devtool工具来修改源码 / using devtool to modify source code under yocto
# https://wiki.phytec.com/pages/viewpage.action?pageId=127338558
# Using devtool to modify recipes in Yocto
# https://wiki.koansoftware.com/index.php/Using_devtool_to_modify_recipes_in_Yocto

# Program boot / kernel and rootfs into emmc
# uuu -b emmc_all imx-boot-imx8ulpevk-sd.bin-flash_singleboot_m33 imx-image-full-imx8ulpevk.wic.zst

# Reduce image size (https://community.nxp.com/t5/i-MX-Processors/Reduces-the-size-of-the-yocto-generated-file-system/m-p/973684)
# You could start from the bigger image and remove packages, or you could start from the core-image-minimal and add packages as needed.
# If you need a graphical interface I would suggest the first approach, starting with the larger image with all required libraries and dependencies and removing the unwanted packages.
# You can list all packages of an image with the command:
# bitbake -g <image> && cat pn-buildlist | grep -ve "native" | sort | uniq
# And then work from there removing unnecessary packages by adding the following line on the conf/local.conf file inside the build directory like so:
# IMAGE_INSTALL_remove += “ package package1 package2”

# Add user into dialout group in Ubuntu to enable access sertial terminal ports