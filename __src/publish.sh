#!/usr/bin/env bash

HELP="Script generate documentation from current sources and pushes to remote Github repository. After executing this
script you need to manually open a Pull Request before it will be deployed. As first parameter please provide name
of branch to publish to, for ex. elaborated-use-cases (note - no spaces are allowed!)"

if [ $# -eq 0 ]
   then
     echo $HELP
     exit 0
fi

if [ $1 -eq 'master' ]
   then
     echo "Please don't try to push to master branch"

BRANCH=$1

git checkout -b update/$BRANCH
bin/sculpin install
bin/sculpin generate --env=prod --url=http://transeu.github.io/api-rest-documentation
mv -r output_prod/* ../
cd ..
git add .
git commit -m"update documentation content"
git push
echo "Now please open a Pull Request on documentation repository https://github.com/Transeu/api-rest-documentation/ "