terraform {
  backend "s3" {
    bucket = "bucket-forterraform"
    key    = "bucket-forterraform/resources/vpc/terraform.tfstate/"
  }
}
