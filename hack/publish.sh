#!/usr/bin/env bash

mkdocs build

if [[ -z "$V_Z2H_DEV_S3_BUCKET" || -z "$V_Z2H_DEV_DISTRIBUTION_ID" ]]; then
  echo "Error: $V_Z2H_DEV_S3_BUCKET and $V_Z2H_DEV_DISTRIBUTION_ID must be set."
  exit 1
fi

aws s3 sync site/ "$V_Z2H_DEV_S3_BUCKET"
aws cloudfront create-invalidation --distribution-id "$V_Z2H_DEV_DISTRIBUTION_ID" --paths "/*"