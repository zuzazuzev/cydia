#!/bin/bash
echo """ZuzaZuzev's Repo
==================
"""
script_full_path=$(dirname "$0")
cd $script_full_path || exit 1

rm Packages Packages.bz2 Packages.xz Packages.zst

echo "[Repository] Appending debs to Packages..."
dpkg-scanpackages debs /dev/null > Packages-iphoneos-arm
dpkg-scanpackages debs /dev/null > Packages-iphoneos-arm64

cat Packages-iphoneos-arm Packages-iphoneos-arm64 > Packages

echo "[Repository] Compressing Packages..."

zstd -q -c19 Packages > Packages.zst
xz -c9 Packages > Packages.xz
bzip2 -c9 Packages > Packages.bz2

echo "[Repository] Done!"
