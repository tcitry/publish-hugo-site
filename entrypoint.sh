#!/bin/sh

REF=$1
if [ -z $1 ]; then
    REF='master'
fi

if [ -z "${TOKEN}" ]; then
  TOKEN=${GITHUB_TOKEN}
fi

if [ -z "${TARGET_REPO}" ]; then
  TARGET_REPO=${GITHUB_REPOSITORY}
fi

REMOTE_REPO="https://${TOKEN}@github.com/${TARGET_REPO}.git"
cd "${GITHUB_WORKSPACE}" || exit 1
git submodule update --init --recursive
rm -rf .git
hugo -v
cd public
git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -m 'Auto Published From Action'
git push --force $REMOTE_REPO master:$REF