terraform {
  backend "s3" {
    bucket               = "bucket-forterraform"
    region               = "ap-southeast-1"
    key                  = "bucket-forterraform/resources/vpc/terraform.tfstate"
  }
}
