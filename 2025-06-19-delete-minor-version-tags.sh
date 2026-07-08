#!/bin/bash
# Delete minor version tags greater than 0.7.0

git fetch --prune --tags
git tag

git tag | awk -F. '($2>7)' | xargs -r git push origin --delete
git tag | awk -F. '($2>7)' | xargs -r git tag --delete

git fetch --prune --tags
git tag
