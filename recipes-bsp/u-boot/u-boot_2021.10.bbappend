
UBOOT_URL = "${RZBOARD_GIT_HOST_MIRROR}/renesas-u-boot.git"
BRANCH = "rzboard_v2l_v2021.10"
SRCREV = "${AUTOREV}"

SRC_URI = "${UBOOT_URL};branch=${BRANCH};${RZBOARD_GIT_PROTOCOL};${RZBOARD_GIT_USER}"