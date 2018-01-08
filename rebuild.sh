#!/bin/bash

replace () {
  if [ "$( uname -s )" = "Darwin" ]; then
    sed -E -i '' "$1" "$2"
  else
    sed -E -i "$1" "$2"
  fi
}

# Start clean.
rm -fr build

# Clone Docker library repo.
git clone --depth 1 https://github.com/docker-library/mysql.git build

MYSQL_VERSION_REGEX="^ENV MYSQL_VERSION ([0-9]+\.[0-9]+\.[0-9]+)"
# Remove volumes from all Dockerfiles.
find build -type f -name Dockerfile -print0 | while IFS= read -r -d $'\0' file
do
  replace "s/^VOLUME/# VOLUME/g" "$file"
  MYSQL_VERSION_COMMAND=$(grep "^ENV MYSQL_VERSION" "$file")
  if [[ $MYSQL_VERSION_COMMAND =~ $MYSQL_VERSION_REGEX ]]; then
    if docker build -q -t "${IMAGE_NAMESPACE:-codycraven}/mysql-novolume:${BASH_REMATCH[1]}" "$(dirname $file)"; then
      echo "Successful build: ${IMAGE_NAMESPACE:-codycraven}/mysql-novolume:${BASH_REMATCH[1]}"
    else
      echo "Failed build: ${IMAGE_NAMESPACE:-codycraven}/mysql-novolume:${BASH_REMATCH[1]}"
    fi
  else
    echo "Skipped build (unexpected/unfound version in Dockerfile): ${IMAGE_NAMESPACE:-codycraven}/mysql-novolume:${BASH_REMATCH[1]}"
  fi
done
