#!/bin/bash

REGION_SRC="ap-southeast-1"
REGION_DST="us-east-1"

mkdir -p migrated_configs

# Loop through tagged functions
while read -r fn; do
  echo "📦 Migrating $fn..."

  # Download function config
  aws lambda get-function-configuration --function-name "$fn" --region "$REGION_SRC" > "migrated_configs/$fn.json"

  # Upload to destination region
  aws lambda create-function \
    --function-name "$fn" \
    --zip-file "fileb://lambda_packages/$fn.zip" \
    --handler $(jq -r .Handler "migrated_configs/$fn.json") \
    --runtime $(jq -r .Runtime "migrated_configs/$fn.json") \
    --role $(jq -r .Role "migrated_configs/$fn.json") \
    --region "$REGION_DST"

done < tagged_functions.txt