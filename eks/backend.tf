terraform {
  backend "s3" {
    bucket = "bucket-forterraform"
    key    = "eksfinal/terraform2.tfstate"
    region = "ap-south-1"
  }
}
