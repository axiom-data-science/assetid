#!/bin/bash

NAME=assetid

if [ $# -eq 0 ]; then
    echo "No version specified, exiting"
    exit 1
fi

VERSION=$1

# Set version to release
sed -i "s/^__version__ = .*/__version__ = \"$VERSION\"/" "${NAME}/__init__.py"
sed -i "s/version: .*/version: \"$VERSION\"/" conda-recipe/meta.yaml
echo $VERSION > VERSION

git add "${NAME}/__init__.py"
git add conda-recipe/meta.yaml
git add VERSION

# Commit release
git commit -m "Release $VERSION"
git tag $VERSION

# Release on PyPi
python setup.py sdist upload

# Push to Git
git push --tags origin master
