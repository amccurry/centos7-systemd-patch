#!/bin/bash
set -e
set -x
SRC_RPM=$(rpm -qa | grep systemd | grep -v devel | grep -v libs | sed -e 's/x86_64/src.rpm/')
wget http://vault.centos.org/7.3.1611/updates/Source/SPackages/${SRC_RPM}
rpm -ivh ${SRC_RPM}

cp systemd-docker-unpriv.patch rpmbuild/SOURCES/

CURRENT_MAX_PATCH=$(cat rpmbuild/SPECS/systemd.spec | grep Patch | tail -n 1 | awk '{print $1}' | sed -e 's/://')
CURRENT_NEW_MAX_PATCH=$(echo ${CURRENT_MAX_PATCH} | sed -e 's/Patch//' | sed 's/^0*//')
CURRENT_NEW_MAX_PATCH=$((CURRENT_NEW_MAX_PATCH+1))
CURRENT_NEW_MAX_PATCH=$(seq -f "%04g" $CURRENT_NEW_MAX_PATCH $CURRENT_NEW_MAX_PATCH)
CURRENT_NEW_MAX_PATCH=$(echo "Patch${CURRENT_NEW_MAX_PATCH}: systemd-docker-unpriv.patch")
sed -i "/${CURRENT_MAX_PATCH}/a ${CURRENT_NEW_MAX_PATCH}" rpmbuild/SPECS/systemd.spec

rpmbuild -ba rpmbuild/SPECS/systemd.spec
cp -r rpmbuild/RPMS/* /output
