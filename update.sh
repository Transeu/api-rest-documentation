#!/usr/bin/env bash

cd _src/
bin/sculpin install
bin/sculpin generate --env=prod --url=http://transeu.github.io/api-rest-documentation
cd ..
cp -rf _src/output_prod/* .
rm -rf _src/output_*
git add .
git commit -m"update documentation content"
git push
echo "Your branch on Github repository has been updated with recent changes"