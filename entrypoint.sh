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

if [ -z "$HUGO_VERSION" ]; then
    HUGO_VERSION=0.54.0
    echo 'No HUGO_VERSION was set, so defaulting to '$HUGO_VERSION
fi

cd "${GITHUB_WORKSPACE}" || exit 1

echo 'installing hugo'
curl -sSL https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz > hugo.tar.gz && tar -zxvf hugo.tar.gz
echo "hugo version is" && ./hugo version
./hugo

git submodule update --init --recursive
rm -rf .git
cd public

if [ -z "${CNAME}" ]; then
    echo "${GITHUB_ACTOR}.github.io" > CNAME
else
    echo ${CNAME} > CNAME
fi

git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -m 'Auto Published From Action'
git push --force $REMOTE_REPO master:$REF