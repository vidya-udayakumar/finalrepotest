    module "eks" {
  source = "../modules/eks"

  cluster_name       = "onecloud"
  vpc_id             = "vpc-00fdaccd57773927f"
  cluster_subnet_ids = ["subnet-0123bfbc9ca78c440","subnet-0c900679692c0a018"]

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
  fargate_profile_subnet_ids = ["subnet-0123bfbc9ca78c440","subnet-0c900679692c0a018"]
  
  common_tags = {
    env     = "dev"
    project = "terrascope"
    region  = "ap-southeast-1"
  }
}
    
