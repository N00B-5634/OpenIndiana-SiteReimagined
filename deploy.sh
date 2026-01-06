#!/bin/bash

echo "🚀 Starting OpenIndiana Reimagined Deployment..."

# 1. Build the MkDocs HTML
echo "📦 Building documentation..."
mkdocs build

# 2. Sync the PDFs so they are available for download
if [ -d "pdf" ]; then
    echo "📄 Syncing PDF downloads..."
    cp -r pdf/ site_docs/
else
    echo "⚠️ Warning: pdf directory not found, skipping PDF sync."
fi

# 3. Ensure .nojekyll exists so GitHub doesn't block the site
touch .nojekyll

# 4. Git Operations
echo "📤 Pushing to GitHub..."
git add .
git commit -m "Site Update: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✅ Success! Your site is updating on GitHub."
echo "URL: https://n00b-5634.github.io/OpenIndiana-SiteReimagined/"
