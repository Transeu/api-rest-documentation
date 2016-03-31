#!/usr/bin/env bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ $BRANCH == "gh-pages" ]
   then
     echo "Please don't try to update main branch directly"
     exit 0
fi

cd _src/
bin/sculpin install
bin/sculpin generate --env=prod --url=http://transeu.github.io/api-rest-documentation
cd ..
cp -rf _src/output_prod/* .
rm -rf _src/output_*
git add .
git commit -m"update documentation content after review"
git push origin $BRANCH
echo "Your branch on Github repository has been updated with recent changes"