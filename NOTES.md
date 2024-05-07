Notes and Goals
===============

I'm trying to take the i.MX93evk + k32w0 USB dongle and build the NXP Matter/Zigbee bridge application for it.

~~Since the version of the i.MX93evk I have is rev A silicon (pre-production) I am limited to using the 6.1.22-2.0.0 Linux image

1. I have since my last work updated my WSL drive size to 512GB (hopefully enough to build a full image on my computer)
2. I have also received an i.MX93-evk Rev B silicon and can use the newer linux images like imx-6.1.55-2.2.0, though my co-workers still have Rev-A so I will try to keep both up to date

useful link
-----------

1. https://www.nxp.com/document/guide/getting-started-with-the-i-mx93-evk:GS-IMX93EVK
2. https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/embedded-linux-for-i-mx-applications-processors:IMXLINUX
3. https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/Matter-Zigbee-Bridge-base-on-i-MX-MPU-and-K32W/ta-p/1675962
4. https://github.com/nxp-imx/meta-matter/blob/imx_matter_2023_q4/README.md
5. https://www.nxp.com/docs/en/user-guide/GSG-IMX8MMINI-MATTER.pdf
6. if using WSL2 : https://github.com/microsoft/WSL/issues/4373
7. https://learn.microsoft.com/en-us/windows/wsl/disk-space

Building
========

in the [base repo](https://github.com/nxp-imx/imx-docker) I found bugs trying to build on Windows 11 and WSL2, no python missing file so I created this fork to help me get those changes into the public. This branch feature/matter is my additions to get the matter build also working.

After checking out this branch you'll need to setup your env.sh file. I linked [imx-6.1.55-2.2.0/env.sh](./imx-6.1.55-2.2.0/env.sh) it to the [env.sh](./env.sh) using `ln -sf imx-6.1.55-2.2.0/env.sh env.sh` command

There are a few things to adjust
1. in the env.sh file you can set your build image you are targeting, since the matter implementation uses "imx-image-multimedia" I changed to that `IMAGES=` instead of *-core. I suspect there may be some trimming that can be done here since I don't need a gui on box. see https://github.com/nxp-imx/imx-manifest for more build IMAGES available.
2. in the env.sh file you can also set your `MACHINE=` target, here I've set the machine to my board the `imx93evk` you can find out which targets are supported by looking here: https://github.com/nxp-imx/meta-imx

WSL2 Note
---------

If running on WSL2 you may need to double check you have enough storage space in your ext4.vhdx file for yocto builds..... see https://learn.microsoft.com/en-us/windows/wsl/disk-space

check where your VHDX file with powershell
`Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss`
Once set you can now build your docker image

Create Docker Image
-------------------

`./docker-build.sh Dockerfile-Ubuntu-22.04`

once built (took about 330s on my laptop) you can then run the full image build with that new docker container just to make sure things are working

Build
-----

`./docker-run.sh imx-6.1.55-2.2.0/yocto-build.sh`

now, it'll place a yocto folder at `/opt/yocto/` however it'll have root privileges and then it'll not be able to populate the needed files and build. so you need to take ownership of the folder `sudo chown <user>:<group> /opt/yoctor -R` replace <user> and <group> with your own user and group

then you can rerun `./docker-run.sh imx-6.1.55-2.2.0/yocto-build.sh` to finish the build. That took for the core image about 1.5 hours on my desktop and about 3 hours on my laptop.

Directly run the docker container
---------------------------------

we can then download the sdk to /opt/nxp/...

run `./docker-run.sh` to drop into the docker shell

Get into the right directory:
`cd ${YOCTO_DIR}`
load up the right environment to run bitbake:
`EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}`
populate the SDK:
`bitbake ${IMAGES} -c populate_sdk`