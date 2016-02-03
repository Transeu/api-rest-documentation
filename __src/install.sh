#!/usr/bin/env bash

echo "Begin Sculpin installation. For troubleshooting please check https://sculpin.io/download/";
cd ~
curl -O https://download.sculpin.io/sculpin.phar
chmod +x sculpin.phar
mv sculpin.phar sculpin
mv sculpin /bin/