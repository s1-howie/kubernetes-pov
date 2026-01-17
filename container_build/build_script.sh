#!/bin/bash

# NOTE:  This script assumes that you've already used "docker login" to log into your registry
CONTAINER_REGISTRY='howiehowerton'
IMAGE_NAME='sentinelone-pov'
VERSION_TAG='1.0'

# If you haven't used buildx before
# docker buildx create --name amd64builder --use
# docker buildx inspect --bootstrap

# Build and push a linux/amd64 and linux/arm64 images to your registry from a Dockerfile in the current working directory
#docker buildx build --platform linux/amd64 -t $CONTAINER_REGISTRY/$IMAGE_NAME:$VERSION_TAG --push .
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t $CONTAINER_REGISTRY/$IMAGE_NAME:$VERSION_TAG \
  --push \
  --provenance=false \
  --metadata-file build-metadata.json \
  .

# Get the sha256 image digest for usage in kubernetes manifests
#docker inspect --format='{{index .RepoDigests 0}}' $CONTAINER_REGISTRY/$IMAGE_NAME:$VERSION_TAG
echo ""
echo "SHA256 digest info:"
docker buildx imagetools inspect --raw $CONTAINER_REGISTRY/$IMAGE_NAME:$VERSION_TAG \
  | jq -r --arg image "$CONTAINER_REGISTRY/$IMAGE_NAME" \
  '.manifests[] | "\(.platform.os)/\(.platform.architecture): \($image)@\(.digest)"'

