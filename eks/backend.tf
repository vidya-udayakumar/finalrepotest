terraform {
  backend "s3" {
    bucket = "bucket-forterraform"
    key    = "eks-updated2/terraform2.tfstate"
    region = "ap-south-1"
  }
}
