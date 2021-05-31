# Terrafile Example Demo

This is a Terraspace project to show how to use a Terrafile.

## Terrafile

The [Terrafile](Terrafile) in this repo is very simple.

```ruby
org "boltops-tools" # set default github org
mod "s3", source: "boltops-tools/terraform-aws-s3"
```

## Install Modules

To install the modules run

    terraspace bundle

This will download the `s3` module to `vendor/modules/s3`

    $ ls vendor/modules/s3
    examples/  main.tf  outputs.tf  README.md  variables.tf
    $

## Use Module

To use the module, it's the same as if the module was in in `app/modules/s3`.  Let's create a `demo` stack.

app/stacks/demo/main.tf

```terraform
resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  source     = "../../modules/s3"  # works for both app/modules/s3 and vendor/modules/s3
  bucket     = "bucket-${random_pet.this.id}"
  acl        = var.acl
}
```

## Why?

Why do both `vendor/modules/s3` and `app/modules/s3` work?

This is because Terraspace detects multiple lookup paths and will use vendor if also found.  This is explained in the:

* [Terraspace Docs: Lookups](https://terraspace.cloud/docs/lookups/)

## Example Output

    $ terraspace up demo -y
    Building .terraspace-cache/us-west-2/dev/stacks/demo
    Built in .terraspace-cache/us-west-2/dev/stacks/demo
    Current directory: .terraspace-cache/us-west-2/dev/stacks/demo
    => terraform plan -input=false -out /tmp/terraspace/plans/demo-626ecf097254c1dcd830dd909844ecf9.plan
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # random_pet.this will be created
      + resource "random_pet" "this" {
          + id        = (known after apply)
          + length    = 2
          + separator = "-"
        }
      # module.bucket.aws_s3_bucket.this will be created
      + resource "aws_s3_bucket" "this" {
          + acceleration_status         = (known after apply)
          + acl                         = "private"
          + arn                         = (known after apply)
          + bucket                      = (known after apply)
          + bucket_domain_name          = (known after apply)
          + bucket_regional_domain_name = (known after apply)
          + force_destroy               = false
          + hosted_zone_id              = (known after apply)
          + id                          = (known after apply)
          + region                      = (known after apply)
          + request_payer               = (known after apply)
          + tags_all                    = (known after apply)
          + website_domain              = (known after apply)
          + website_endpoint            = (known after apply)

          + versioning {
              + enabled    = (known after apply)
              + mfa_delete = (known after apply)
            }
        }

    Plan: 2 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + bucket_name = (known after apply)

    ------------------------------------------------------------------------

    This plan was saved to: /tmp/terraspace/plans/demo-626ecf097254c1dcd830dd909844ecf9.plan

    To perform exactly these actions, run the following command to apply:
        terraform apply "/tmp/terraspace/plans/demo-626ecf097254c1dcd830dd909844ecf9.plan"
    => terraform apply -auto-approve -input=false /tmp/terraspace/plans/demo-626ecf097254c1dcd830dd909844ecf9.plan
    random_pet.this: Creating...
    random_pet.this: Creation complete after 0s [id=crucial-doberman]
    module.bucket.aws_s3_bucket.this: Creating...
    module.bucket.aws_s3_bucket.this: Creation complete after 1s [id=bucket-crucial-doberman]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:
    bucket_name = "bucket-crucial-doberman"
    Time took: 4s
    $