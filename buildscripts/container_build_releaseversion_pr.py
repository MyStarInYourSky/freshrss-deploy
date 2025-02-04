#!/usr/bin/env python3
import semver
import sys
target_image_version = semver.Version.parse(sys.argv[1])
registry_image_version = semver.Version.parse(sys.argv[2])

prerelease = registry_image_version.prerelease
target_image_patched = target_image_version.replace(prerelease=prerelease)

if target_image_patched == registry_image_version:
  print(str(target_image_patched.bump_prerelease(token='')))
elif target_image_patched > registry_image_version:
  print(str(target_image_version.bump_prerelease(token='')))
