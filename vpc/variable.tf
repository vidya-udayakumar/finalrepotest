variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "vpc_tag" {
  default = "16300419-ESG-VPC"
}

variable "subnet_availability_zone_env_1" {
  default = "ap-southeast-1a"
}

variable "subnet_availability_zone_env_2" {
  default = "ap-southeast-1b"
}

#####   Public Subnet   #############

variable "public_subnet_tag_1" {
  default = "16300419-ESG-controlplane-dev-pubic-sub-1"
}

variable "public_subnet_tag_2" {
  default = "16300419-ESG-controlplane-dev-pubic-sub-2"
}

variable "subnet_cidr_block_1" {
  default = "10.100.0.0/24"
}

variable "subnet_cidr_block_2" {
  default = "10.100.1.0/24"
}

variable "public_route_tag" {
  default = "16300419-ESG-public-RT"
}

variable "route_cidr" {
  default = "0.0.0.0/0"
}

variable "igw_tag" {
  default = "16300419-ESG-IGW"
}

variable "public_nacl_tag" {
  default = "16300419-ESG-nacl-1"
}

######   Private Subnet    #######

variable "private_subnet_1_tag" {
  default = "16300419-ESG-controlplane-dev-private-sub-1"
}

variable "private_subnet_2_tag" {
  default = "16300419-ESG-controlplane-dev-private-sub-1"
}

variable "tgw_tag" {
  default = "16300419-ESG-TGW"
}

variable "private_route_tag" {
  default = "16300419-ESG-private-RT"
}

variable "private_subnet_cidr_block_3" {
  default = "10.100.2.0/24"
}

variable "private_subnet_cidr_block_4" {
  default = "10.100.3.0/24"
}

variable "private_nacl_tag" {
  default = "16300419-ESG-private-nacl"
}
