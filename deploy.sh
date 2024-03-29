#!/bin/bash

# if [[ $(git status -s) ]]
# then
#     echo "The working directory is dirty. Please commit any pending changes."
#     exit 1;
# fi

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Getting latest commit id"
commit_id=$(git rev-parse HEAD)
echo $commit_id

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd public
git config user.email "kanta208@gmail.com"
git config user.name "otomarukanta"
git add --all
git commit -m "Publish $commit_id [ci skip]"
git push origin gh-pages
