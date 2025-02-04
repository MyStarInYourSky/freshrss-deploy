echo "Build Required: $BUILD_REQUIRED"
echo "Release Required: $RELEASE_REQUIRED"
if [[ $BUILD_REQUIRED == "True" ]]; then
  buildah pull oci-archive:$(pwd)/freshrss_386
  buildah pull oci-archive:$(pwd)/freshrss_arm64
  buildah pull oci-archive:$(pwd)/freshrss_amd64
  buildah pull oci-archive:$(pwd)/freshrss_armv6
  buildah pull oci-archive:$(pwd)/freshrss_armv7
  buildah manifest create "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}"
  buildah manifest add --arch=386 "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-386"
  buildah manifest add --arch=arm64 "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-arm64"
  buildah manifest add --arch=amd64 "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-amd64"
  buildah manifest add --arch=arm --variant=v6 "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-armv6"
  buildah manifest add --arch=arm --variant=v7 "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-armv7"
  buildah manifest create "ghcr.io/mystarinyoursky/freshrss:latest"
  buildah manifest add --arch=386 "ghcr.io/mystarinyoursky/freshrss:latest" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-386"
  buildah manifest add --arch=arm64 "ghcr.io/mystarinyoursky/freshrss:latest" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-arm64"
  buildah manifest add --arch=amd64 "ghcr.io/mystarinyoursky/freshrss:latest" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-amd64"
  buildah manifest add --arch=arm --variant=v6 "ghcr.io/mystarinyoursky/freshrss:latest" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-armv6"
  buildah manifest add --arch=arm --variant=v7 "ghcr.io/mystarinyoursky/freshrss:latest" "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}-armv7"
  buildah manifest push --all "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "docker://ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}"
  buildah manifest push --all "ghcr.io/mystarinyoursky/freshrss:latest" "docker://ghcr.io/mystarinyoursky/freshrss:latest"
fi

if [[ $RELEASE_REQUIRED == "True" ]]; then
  buildah manifest push --all "ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}" "docker://ghcr.io/mystarinyoursky/freshrss:${CONTAINER_VERSION}"
  buildah manifest push --all "ghcr.io/mystarinyoursky/freshrss:latest" "docker://ghcr.io/mystarinyoursky/freshrss:latest"
fi
