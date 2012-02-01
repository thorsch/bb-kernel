#!/bin/bash
#
# Copyright (c) 2009-2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

function git_add {
git add .
git commit -a -m 'testing patchset'
}

function bugs_trivial {
echo "bugs and trivial stuff"

patch -s -p1 < "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
}

function am33x-cleanup {
echo "[git] am33x-cleanup"
git pull git://github.com/RobertCNelson/linux.git ti_am33x_v3.2-staging_psp0

git am "${DIR}/patches/arago-am33x/0001-arm-omap-am33xx-add-missing-i2c-pin-mus-details.patch"
git am "${DIR}/patches/arago-am33x/0002-arm-omap-am33xx-add-i2c2-hwmod-data.patch"
git am "${DIR}/patches/arago-am33x/0003-arm-omap-am33xx-register-i2c2-for-beaglebone.patch"

git am "${DIR}/patches/bone-merge/0001-bone-arago-angstrom-merge.patch"
}

function am33x {
echo "[git] am33x"
git pull git://github.com/RobertCNelson/linux.git ti_am33x_v3.2-staging_psp0

git am "${DIR}/patches/bone/0001-beaglebone-rebase-everything-onto-3.2-WARNING-MEGAPA.patch"
git am "${DIR}/patches/bone/0002-more-beaglebone-merges.patch"
git am "${DIR}/patches/bone/0003-beaglebone-disable-tsadc.patch"
git am "${DIR}/patches/bone/0004-tscadc-Add-general-purpose-mode-untested-with-touchs.patch"
git am "${DIR}/patches/bone/0005-tscadc-Add-board-file-mfd-support-fix-warning.patch"
git am "${DIR}/patches/bone/0006-AM335X-init-tsc-bone-style-for-new-boards.patch"
git am "${DIR}/patches/bone/0007-tscadc-make-stepconfig-channel-configurable.patch"
git am "${DIR}/patches/bone/0008-tscadc-Trigger-through-sysfs.patch"
git am "${DIR}/patches/bone/0009-meta-ti-Remove-debug-messages-for-meta-ti.patch"
git am "${DIR}/patches/bone/0010-tscadc-switch-to-polling-instead-of-interrupts.patch"
git am "${DIR}/patches/bone/0011-beaglebone-fix-ADC-init.patch"
git am "${DIR}/patches/bone/0012-beaglebone-add-defconfig.patch"
git am "${DIR}/patches/bone/0013-AM335x-MUX-add-ehrpwm1A.patch"
git am "${DIR}/patches/bone/0014-beaglebone-enable-PWM-for-lcd-backlight-backlight-is.patch"
git am "${DIR}/patches/bone/0015-omap_hsmmc-Set-dto-to-max-value-of-14-to-avoid-SD-Ca.patch"
git am "${DIR}/patches/bone/0016-beaglebone-set-default-brightness-to-50-for-pwm-back.patch"

}

bugs_trivial

#patches in git
am33x-cleanup

echo "patch.sh ran successful"

