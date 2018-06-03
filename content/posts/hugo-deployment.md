---
title: "Hugo Deployment"
date: 2018-06-02T18:06:49+09:00
draft: true
description: ""
featured_image: "/images/hugo-logo.png"
tags: [hugo]
toc: true
---

# Hugo デプロイ

参考: [Hosting & Deployment](https://gohugo.io/hosting-and-deployment/)


## config.toml編集

{{< highlight toml >}}

{{< /highlight >}}

## Repositoryにpush

{{< highlight bash >}}
$ git commit -m 'first commit'
$ git remote add origin <repository url>
$ git push -u origin master
{{< /highlight >}}

## gh-pagesブランチ作成

## deploy.shスクリプト作成

{{< highlight bash >}}
#!/bin/bash

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
git subtree push --prefix=public git@github.com:<user name>/<repo name>.git gh-pages
{{< /highlight >}}