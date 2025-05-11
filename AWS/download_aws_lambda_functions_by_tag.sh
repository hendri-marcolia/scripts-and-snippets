#!/bin/bash

# Tag key-value to filter
TAG_KEY="AppTagHere"

echo "🔍 Searching for Lambda functions with tag: $TAG_KEY..."

# Step 1: Get all Lambda function names
aws lambda list-functions --query 'Functions[*].FunctionName' --output text | tr '\t' '\n' > all_functions.txt

# Step 2: Filter functions by tag
> tagged_functions.txt
while read -r function_name; do
  tag_value=$(aws lambda list-tags --resource arn:aws:lambda:$(aws configure get region):$(aws sts get-caller-identity --query Account --output text):function:$function_name \
               --query "Tags.${TAG_KEY}" --output text 2>/dev/null)
  if [[ "$tag_value" != "None" ]]; then
    echo "$function_name" >> tagged_functions.txt
    echo "✅ Tagged function found: $function_name"
  fi
done < all_functions.txt

# Step 3: Download deployment packages
mkdir -p lambda_packages
while read -r function_name; do
  echo "⬇️ Downloading $function_name..."
  url=$(aws lambda get-function --function-name "$function_name" --query 'Code.Location' --output text)
  wget -q -O "lambda_packages/${function_name}.zip" "$url"
  echo "📦 Saved to lambda_packages/${function_name}.zip"
done < tagged_functions.txt

echo "✅ Done. All functions with tag '$TAG_KEY' downloaded to ./lambda_packages"
