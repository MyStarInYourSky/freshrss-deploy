#!/bin/bash -e

export APP_VERSION=$(curl -s -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/FreshRSS/FreshRSS/releases | jq -r '.[] | select(.prerelease == false)| select(.draft == false) | .tag_name' | sort -V | tail -1)
#export REGISTRY_VERSION=$(curl -s -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" -H "Authorization: Bearer ${GITHUB_TOKEN}" https://api.github.com/orgs/MyStarInYourSky/packages/container/freshrss/versions | jq -r '.[].metadata.container.tags.[]| select(. != "latest")' | sort -V  | tail -1)
export REGISTRY_VERSION="0.0.0"

# Set Build Params
if [ $EVENT_NAME == "pull_request" ]; then # Handle Pull Requests
  echo "BUILD_REQUIRED=True" >> $GITHUB_OUTPUT
  echo "RELEASE_REQUIRED=False" >> $GITHUB_OUTPUT
  export BUILD_REQUIRED="True"
  export RELEASE_REQUIRED="False"
  export CONTAINER_VERSION=$(../buildscripts/container_build_releaseversion_pr.py "$APP_VERSION" "$REGISTRY_VERSION")
elif [ $EVENT_NAME == "push" ]; then  # Handle Merging
  echo "BUILD_REQUIRED=True" >> $GITHUB_OUTPUT
  echo "RELEASE_REQUIRED=True" >> $GITHUB_OUTPUT
  export BUILD_REQUIRED="True"
  export RELEASE_REQUIRED="True"
  export CONTAINER_VERSION=$(../buildscripts/container_build_releaseversion_pr.py "$APP_VERSION" "$REGISTRY_VERSION")
elif [ $EVENT_NAME == "schedule" ];  then # Handle Scheduled Run
  if [ $(../buildscripts/container_version_compare.py "$APP_VERSION" "$REGISTRY_VERSION") == True ]; then
    echo "Trigger Build"
    echo "BUILD_REQUIRED=True" >> $GITHUB_OUTPUT
    echo "RELEASE_REQUIRED=True" >> $GITHUB_OUTPUT
    export BUILD_REQUIRED="True"
    export RELEASE_REQUIRED="True"
    export CONTAINER_VERSION=$(../buildscripts/container_build_releaseversion_pr.py "$APP_VERSION" "$REGISTRY_VERSION")
  else
    echo "BUILD_REQUIRED=False" >> $GITHUB_OUTPUT
    echo "RELEASE_REQUIRED=False" >> $GITHUB_OUTPUT
    export BUILD_REQUIRED="False"
    export RELEASE_REQUIRED="False"
    export CONTAINER_VERSION=$REGISTRY_VERSION
  fi
fi

# Set Additional Build Params that are not event scoped
echo "PHP_API_VERSION=$(docker run -i $CONTAINER_BUILD_BASEIMAGE php -i | grep 'PHP API' | awk -F ' ' '{print $4}' | tr -d '\r')" >> $GITHUB_OUTPUT

echo "CONTAINER_VERSION=$CONTAINER_VERSION" >> $GITHUB_OUTPUT
echo "APP_VERSION=$APP_VERSION" >> $GITHUB_OUTPUT
echo "=========================="
echo "FreshRSS Version: $APP_VERSION"
echo "Registry Version: $REGISTRY_VERSION"
echo "New Container Version: $CONTAINER_VERSION"
echo "Build Required: $BUILD_REQUIRED"
echo "Release Required: $RELEASE_REQUIRED"
