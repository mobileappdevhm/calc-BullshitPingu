#!/usr/bin/env bash

# Create new output directory
mkdir $HOME/output/

# Copy generated APK from build folder
cp -R build/app/outputs/apk/release/apk-release.apk $HOME/android/

# Go to home and setup git
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

# Clone the repository
git clone --quiet --branch master = https://BullshitPingu:${GitHub}@github.com/mobileappdevhm/calc-BullshitPingu.git > /dev/null

# Copy needed files to repository
cd master
cp -Rf $HOME/android/*.

# Add, commit and push files
git remote rm origin
git remote add origin https://BullshitPingu:${GitHub}@github.com/mobileappdevhm/calc-BullshitPingu.git
git add .
git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"
git push origin master -fq > /dev/null