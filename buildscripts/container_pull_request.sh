#!/bin/bash -e

# Install Dependencies
sudo apt update
sudo apt -y install jq curl
sudo pip3 install semver

export APP_VERSION=$(curl -s -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/FreshRSS/FreshRSS/releases | jq -r '.[] | select(.prerelease == false)| select(.draft == false) | .tag_name' | sort -V | tail -1)
export REGISTRY_VERSION=$(curl -s -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" -H "Authorization: Bearer ${GITHUB_TOKEN}" https://api.github.com/orgs/MyStarInYourSky/packages/container/freshrss/versions | jq -r '.[].metadata.container.tags.[]| select(. != "latest")' | sort -V  | tail -1)
export CONTAINER_VERSION=$(buildscripts/container_build_releaseversion_pr.py "$APP_VERSION" "$REGISTRY_VERSION")
echo "BUILD_REQUIRED=True" >> $GITHUB_OUTPUT
echo "RELEASE_REQUIRED=False" >> $GITHUB_OUTPUT
echo "CONTAINER_VERSION=$CONTAINER_VERSION" >> $GITHUB_OUTPUT
echo "APP_VERSION=$APP_VERSION" >> $GITHUB_OUTPUT
echo "=========================="
echo "FreshRSS Version: $APP_VERSION"
echo "Registry Version: $REGISTRY_VERSION"
echo "New Container Version: $CONTAINER_VERSION"
