    module "eks" {
  source = "../modules/eks"

  cluster_name       = "ts-cp-dev-eks-1"
  vpc_id             = "vpc-0e3953cb26597b2f0"
  cluster_subnet_ids = ["subnet-02cd374dcc97ccbaf","subnet-0a5377b67f1a03afb"]

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
  fargate_profile_subnet_ids = ["subnet-02cd374dcc97ccbaf","subnet-0a5377b67f1a03afb"]
  
  common_tags = {
    env     = "dev"
    project = "terrascope"
    region  = "ap-southeast-1"
  }
}
    
