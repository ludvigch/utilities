#!/bin/bash
set -e

virt-install \
--name fedora \
--vcpus $(( $(nproc) / 2)) \
--memory $(( $(nproc) * 1024)) \
--cpu host \
--network network=default \
--boot uefi \
--location https://download.fedoraproject.org/pub/fedora/linux/releases/42/Server/$(uname -m)/os \
--disk size=10,format=qcow2 \
--virt-type kvm \
--console pty,target_type=serial \
--extra-args "console=ttyS0,115200n8" \
--graphics none