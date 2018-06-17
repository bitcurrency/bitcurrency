#!/usr/bin/env bash
#
# https://gist.github.com/dennishafemann/8371080

PACKAGE_DIR=$1
DEB_OUTPUT_DIR=$2
ARCH=$3

NAME_PACKAGE="Package"
NAME_VERSION="Version"
DEBIAN_CONTROL_FILE="DEBIAN/control"

# Get package size
packageSize=$(du -s "${PACKAGE_DIR}/" | cut -f 1)

# Get build name
packageName=$(grep "${NAME_PACKAGE}" < "${PACKAGE_DIR}/${DEBIAN_CONTROL_FILE}" | cut -d " " -f 2)

# Get build number
packageBuildNr=$(grep "${NAME_VERSION}" < "${PACKAGE_DIR}/${DEBIAN_CONTROL_FILE}" | cut -d " " -f 2)

# Change package size
echo "* Change package size in control-file (if Installed-Size is available) ..."
sed -i "s/\(Installed-Size:\).*/\\1 ${packageSize}/g" "${PACKAGE_DIR}/${DEBIAN_CONTROL_FILE}"
echo

# Build packages
echo "* Build package ..."
dpkg -b "./${PACKAGE_DIR}" "${DEB_OUTPUT_DIR}/${packageName}_${packageBuildNr}_${ARCH}.deb"
echo

# Build md5sum of deb-file
echo "* Build md5sum-file ..."
md5sum "${DEB_OUTPUT_DIR}/${packageName}_${packageBuildNr}_${ARCH}.deb" > "${DEB_OUTPUT_DIR}/${packageName}_${packageBuildNr}_${ARCH}.deb.md5sum"
echo

echo "Finished."
echo
