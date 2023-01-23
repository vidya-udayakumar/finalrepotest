resource "null_resource" "authenticate_kubectl" {
    provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [
    aws_eks_fargate_profile.fargate_profiles
  ]
}


resource "null_resource" "service_account_creation" {
    provisioner "local-exec" {
    command = "eksctl create iamserviceaccount --cluster=${var.cluster_name} --namespace=kube-system --name=aws-load-balancer-controller --attach-policy-arn=arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AWSLoadBalancerControllerIAMPolicy --override-existing-serviceaccounts --approve"
  }
  depends_on = [
    null_resource.authenticate_kubectl
  ]
}

resource "null_resource" "service_account_creation_check" {
    provisioner "local-exec" {
    command = "eksctl get iamserviceaccount --cluster ${var.cluster_name} --name aws-load-balancer-controller --namespace kube-system"
  }
  depends_on = [
    null_resource.service_account_creation
  ]
}

resource "null_resource" "add_eks_helm_repo" {
    provisioner "local-exec" {
    command = "helm repo add eks https://aws.github.io/eks-charts"
  }
  depends_on = [
    null_resource.service_account_creation_check
  ]

}

resource "null_resource" "kubectl_elb_config" {
    provisioner "local-exec" {
    command = "kubectl apply -k ${"github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"}"
  }
  depends_on = [
    null_resource.add_eks_helm_repo
  ]
}

resource "null_resource" "install_load_balancer_helm" {
    provisioner "local-exec" {
    command = "helm install aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=${var.cluster_name} --set serviceAccount.create=false --set region=${data.aws_region.current.name} --set vpcId=${var.vpc_id} --set serviceAccount.name=aws-load-balancer-controller -n kube-system"
  }
  depends_on = [
    null_resource.kubectl_elb_config
  ]
}

resource "null_resource" "deploy_application" {
    provisioner "local-exec" {
    command = "kubectl apply -f ./2048-app.yaml"
  }
  depends_on = [
    null_resource.install_load_balancer_helm
  ]
}

resource "null_resource" "check_app_ingress" {
    provisioner "local-exec" {
    command = "kubectl get ingress/ingress-2048 -n game-2048"
  }
  depends_on = [
    null_resource.deploy_application
  ]
}
