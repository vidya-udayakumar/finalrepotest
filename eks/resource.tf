module "eks-dev" {
    source = "./module"
    name = "testthwlb"
    subnet_ids = ["subnet-0a072ab649998332a", "subnet-0e31d001d74f5fd4a"]
    cluster_version = "1.24"
}
