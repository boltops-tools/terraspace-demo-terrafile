resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  source     = "../.."
  bucket     = "bucket-${random_pet.this.id}"
  acl        = var.acl
}
