# Terraform Example S3 Bucket Module

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Simple example s3 bucket.

## Add to Terrafile

```ruby
mod "s3", source: "boltops-tools/terraform-aws-s3", stacks: :all
```

## Deploy

    terraspace up s3

## Clean Up

    terraspace down s3

test5
