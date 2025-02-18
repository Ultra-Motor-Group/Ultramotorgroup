#!/bin/bash

# Exit if any command fails
set -e

echo "🚀 Starting deployment process..."

# Step 1: Clone the repository
echo "Cloning repository..."
git clone https://github.com/carrolls928/UMGTRYAGAIN.git
cd UMGTRYAGAIN

# Step 2: Install dependencies
echo "Installing dependencies..."
npm install

# Step 3: Create the necessary API folder and files
echo "Setting up API..."
mkdir -p api
cat <<EOF > api/products.js
module.exports = (req, res) => {
  res.status(200).json([
    { id: 1, name: "Performance Exhaust", price: "$499" },
    { id: 2, name: "Racing Tires", price: "$299" }
  ]);
};
EOF

# Step 4: Create or overwrite vercel.json
cat <<EOF > vercel.json
{
  "version": 2,
  "builds": [
    {
      "src": "api/products.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/api/products",
      "dest": "api/products.js"
    }
  ]
}
EOF

# Step 5: Commit changes to GitHub
echo "Committing changes..."
git add api/products.js vercel.json
git commit -m "Fix Vercel API route"
git push origin main

# Step 6: Deploy to Vercel
echo "Deploying to Vercel..."
vercel --prod

echo "🎉 Deployment complete! Check your API at:"
echo "👉 https://your-vercel-project-url.vercel.app/api/products"
