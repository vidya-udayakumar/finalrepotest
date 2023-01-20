terraform {
  backend "s3" {
    bucket = "bucket-forterraform"
    key    = "bucket-forterraform/resources/securityhub/terraform.tfstate"
    region = "ap-south-1"
  }
}
