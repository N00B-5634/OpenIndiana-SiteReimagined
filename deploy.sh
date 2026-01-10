#!/bin/bash

echo " Starting OpenIndiana-Reimagined Deployment..."

# 1. Build the MkDocs HTML
echo " Building documentation..."
mkdocs build

# 2. Sync the PDFs
if [ -d "pdf" ]; then
    echo " Syncing PDF downloads..."
    cp -r pdf/ site_docs/
fi

# 3. Ensure .nojekyll exists
touch .nojekyll

# 4. Git Operations
echo " Syncing with GitHub (Pulling)..."
# This pulls changes from GitHub and merges them with yours
git pull origin main --rebase

echo " Pushing to GitHub..."
git add .
git commit -m "Site Update: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

# Check if push was actually successful
if [ $? -eq 0 ]; then
    echo "Success! Your site is live."
    echo "URL: https://n00b-5634.github.io/OpenIndiana-SiteReimagined/"
else
    echo " Error: The push failed."
fi
