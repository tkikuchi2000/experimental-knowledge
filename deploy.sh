#!/bin/bash
set -x

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
# hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -t ananke

# Go To Public folder
cd public
# Add changes to git.
git add -A 

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
cd ..
git subtree push --prefix=public https://github.com/tkikuchi2000/experimental-knowledge.git gh-pages