#!/bin/bash

NAME=assetid

if [ $# -eq 0 ]; then
    echo "No version specified, exiting"
    exit 1
fi

VERSION=$1

# Set version to release
echo $VERSION > VERSION
sed -i "s/^__version__ = .*/__version__ = \"$VERSION\"/" "${NAME}/__init__.py"

git add VERSION
git add "${NAME}/__init__.py"

# Commit release
git commit -m "Release $VERSION"
git tag $VERSION

# Release on PyPi
python setup.py sdist upload

# Push to Git
git push --tags
git push
