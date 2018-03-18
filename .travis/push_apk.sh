#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_files() {
  mkdir out
  cp build/app/outputs/apk/release/app-release.apk out/app-release.apk
  git add out/app-release.apk
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin https://${GitHub}@github.com/mobileappdevhm/calc-BullshitPingu.git > /dev/null 2>&1
  git push --quiet origin
}

setup_git
commit_files
upload_files