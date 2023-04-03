# meta-rzboard

This is a meta-layer for Avnet RzBoard.

- Yocto dunfell 3.1.14 support:  Avnet RzBoard



## How to Build


### Build environment

It is recommended to setup the development environment on a *<font color=red>64-bit Ubuntu 20.04 LTS</font>* machine.
The following packages are required:

```bash
$ sudo apt update
$ sudo apt install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping libsdl1.2-dev xterm p7zip-full libyaml-dev \
rsync curl locales bash-completion
```

Set Git configuration:

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "you@example.com"
```



### Fetch the source code

* ##### **Download Renesas software packages**

Due to licensing restrictions on the Renesas website, users are required to download the software packages from the [Official RZ/V2L Website](https://www.renesas.cn/us/en/products/microcontrollers-microprocessors/rz-mpus/rzv2l-general-purpose-microprocessor-equipped-renesas-original-ai-accelerator-drp-ai-12ghz-dual) in person.

The following packages should be download:

| Package Name                  | Version                    | Download File                               | Link                                                                           |
| ----------------------------- | -------------------------- | ------------------------------------------- | ---- |
| RZ/V Verified Linux Package   | V3.0.2             | RTK0EF0045Z0024AZJ-v3.0.2.zip | https://www.renesas.com/us/en/software-tool/rzv-verified-linux-package#overview |
| RZ MPU Graphics Library (Eval) | Evaluaton Version V1.4 | RTK0EF0045Z13001ZJ-v1.4_EN.zip | https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rz-mpu-graphics-library-evaluation-version-rzv2l#overview |
| RZ MPU Graphics Library       | Unrestricted Version V1.4 | - | https://www.renesas.com/us/en/document/sws/rz-mpu-graphics-library-v14-unrestricted-version-verified-linux-package-rzv2lrtk0ef0045z14001zj |
| RZ MPU Codec Library          | Evaluation Version V1.0.1  | RTK0EF0045Z15001ZJ-v1.0.1_EN.zip | https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rz-mpu-video-codec-library-evaluation-version-rzv2l
| RZ MPU Codec Library          | Unrestricted Version V1.0.1  | - | https://www.renesas.com/us/en/document/sws/rz-mpu-video-codec-library-v101-unrestricted-version-verified-linux-package-rzv2l-rtk0ef0045z16001zj | 
| RZ/V2L DRP-AI Support Package | V7.30                      | r11an0549ej0730-rzv2l-drpai-sp.zip | https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rzv2l-drp-ai-support-package#overview |
| RZ/V2L ISP Support Package    | V1.21                      | r11an0561ej0121-rzv2l-isp-sp.zip | https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rzv2l-isp-support-package |
| RZ/V2L Multi-OS Package       | V1.10                      | r01an6238ej0110-rzv2l-cm33-multi-os-pkg.zip | https://www.renesas.com/us/en/software-tool/rzv2l-group-multi-os-package |

***Note***: *The Renesas website provides two version packages, "Evaluation Version" and "Unrestricted Version", for each of the **Graphics Library** and the **Codec Library**. It is recommended to download the **Unrestricted Version**, as the Evaluation Version contains a time limitation that stops the software after a few hours.*

For more information please refer to [RZ/V2L Wiki](https://renesas.info/wiki/RZ-V/RZ-V2L_SMARC) and [RZ/V2 Linux BSP](https://renesas.info/wiki/RZ-G/RZ-G2_BSP).



After getting all the packages, copy them to **the home directory ( ~/ )** and prepare for the next step.



* ##### **Extract Renesas software packages**

Download a script to extract the file
```bash
$ cd ~/
$ wget https://raw.githubusercontent.com/Avnet/meta-rzboard/rzboard_dunfell_5.10/tools/create_yocto_rz_src.sh
$ chmod a+x create_yocto_rz_src.sh
$ ls ~/
create_yocto_rz_src.sh                       RTK0EF0045Z0024AZJ-v3.0.0-update2.zip
r01an6238ej0102-rzv2l-cm33-multi-os-pkg.zip  RTK0EF0045Z14001ZJ-v1.21_EN.zip
r11an0549ej0720-rzv2l-drpai-sp.zip           RTK0EF0045Z16001ZJ-v1.0_rzg_EN.zip
r11an0561ej0120-rzv2l-isp-sp.zip
```
Run the script to generate **yocto_rzboard/** directory
```bash
$ ./create_yocto_rz_src.sh
$ ls yocto_rzboard/
meta-gplv2     meta-openembedded  meta-renesas      meta-virtualization
meta-multi-os  meta-qt5           meta-rz-features  poky
```



* ##### **Download meta-rzboard**

```bash
$ cd ~/yocto_rzboard
$ git clone https://github.com/Avnet/meta-rzboard.git -b rzboard_dunfell_5.10
```

So far, all the yocto related sources are in place.

```bash
$ ls ~/yocto_rzboard
meta-gplv2     meta-openembedded  meta-renesas      meta-rzboard         poky
meta-multi-os  meta-qt5           meta-rz-features  meta-virtualization
```



### Build a image

*  ##### **Create build configuration**

```bash
$ cd ~/yocto_rzboard
$ mkdir -p ~/yocto_rzboard/build/conf
$ cp meta-rzboard/conf/rzboard/* build/conf/
$ ls build/conf/
bblayers.conf  local.conf
```

*  ##### **Build**
```bash
$ cd ~/yocto_rzboard/
$ source poky/oe-init-build-env build/
$ bitbake avnet-core-image
```
After the build is successfully completed, the output files will be located in build/tmp/deploy/images/rzboard/ directory.
