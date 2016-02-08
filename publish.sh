#!/usr/bin/env bash

HELP="Script generate documentation from current sources and pushes to remote Github repository. After executing this
script you need to manually open a Pull Request before it will be deployed. As first parameter please provide name
of branch to publish to, for ex. elaborated-use-cases (note - no spaces are allowed!)"

if [ $# -eq 0 ]
   then
     echo $HELP
     exit 0
fi

if [ $1 == "gh-pages" ]
   then
     echo "Please don't try to push to main branch"
     exit 0
fi

BRANCH=$1

git checkout -b feature/$BRANCH
cd _src/
bin/sculpin generate --env=prod --url=http://transeu.github.io/api-rest-documentation
cd ..
cp -rf _src/output_prod/* .
rm -rf _src/output_*
git add .
git commit -m"update documentation content"
git push
echo "Now please open a Pull Request in documentation repository https://github.com/Transeu/api-rest-documentation/"