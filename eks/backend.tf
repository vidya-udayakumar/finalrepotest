terraform {
  backend "s3" {
    bucket = "bucket-forterraform"
    key    = "eks-updated2/terraform1.tfstate"
    region = "ap-south-1"
  }
}
