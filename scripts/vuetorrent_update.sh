#!/bin/bash -e

cd /opt

echo "current version: $(cat vuetorrent/version.txt)"

wget --show-progress -q https://github.com/VueTorrent/VueTorrent/releases/latest/download/vuetorrent.zip
unzip -qo vuetorrent.zip
rm -f vuetorrent.zip

echo "new version: $(cat vuetorrent/version.txt)"
