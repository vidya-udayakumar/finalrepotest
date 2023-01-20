terraform {
  backend "s3" {
    bucket  = "bucket-forterraform"
    key     = "state.tfstate"
    region  = "ap-south-1"
  }
}
