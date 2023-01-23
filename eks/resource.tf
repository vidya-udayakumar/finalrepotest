    module "eks" {
  source = "../modules/eks"

  cluster_name       = "onecloud"
  vpc_id             = "vpc-0000d344a4961c079"
  cluster_subnet_ids = ["subnet-0512fcd945c4055ca","subnet-0b36ff30ad2275ba4"]

  fargate_profiles = {
    fp-default = {
      name      = "fp-default"
      selectors = [{ namespace = "default" }, { namespace = "kube-system" }]
    },
    alb-sample-app = {
      name      = "alb-sample-app"
      selectors = [{ namespace = "fp-dev" }]
    }
  }
  fargate_profile_subnet_ids = ["subnet-0512fcd945c4055ca","subnet-0b36ff30ad2275ba4"]
  
  common_tags = {
    env     = "dev"
    project = "terrascope"
    region  = "ap-southeast-1"
  }
}
    
