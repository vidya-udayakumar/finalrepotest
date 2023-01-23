variable "common_tags" {
  type = map(any)
  default = {
    env     = "dev"
    project = "control_plane"
    region  = "ap-southeast-1"
  }
}


variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cluster_subnet_ids" {
  type = list(string)
}

variable "fargate_profiles" {
  type    = any
  default = {}
  ######sample input#################
  # backend = {
  #   name = join("-", [local.prefix, "core"])
  #   selectors = [
  #     {
  #       namespace = local.prefix
  #       labels = {
  #         "app.kubernetes.io/name" = "core"
  #       }
  #     }
  #   ]
  #   tags = merge(local.common_tags, tomap({ Namespace = "Default" }))
  #   timeouts = {
  #     create = "20m"
  #     delete = "20m"
  #   }
  # },
}

variable "fargate_profile_subnet_ids" {
  type = list(string)
}

