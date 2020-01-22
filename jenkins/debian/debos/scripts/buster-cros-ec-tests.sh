#!/bin/bash

# Important: This script is run under QEMU

set -e

# Build-depends needed to build the test suites, they'll be removed later
BUILD_DEPS="\
    git \
    python3-setuptools \
    python3-pip \
"

apt-get install --no-install-recommends -y ${BUILD_DEPS}

########################################################################
# Build tests                                                          #
########################################################################

BUILDFILE=/test_suites.json
echo '{  "tests_suites": [' >> $BUILDFILE

########################################################################
# Build and install tests                                              #
########################################################################

pip3 install git+https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/cros-ec-tests.git

########################################################################
# Cleanup: remove files and packages we don't want in the images       #
########################################################################

rm -fr /src/cros-ec-tests
apt-get remove --purge -y ${BUILD_DEPS} perl-modules-5.28
apt-get autoremove --purge -y
apt-get clean

