module "eks-dev" {
    source = "../modules/eks"
    name = "clusscope"
    subnet_ids = ["subnet-0a072ab649998332a", "subnet-0e31d001d74f5fd4a"]
    cluster_version = "1.24"
}

    
