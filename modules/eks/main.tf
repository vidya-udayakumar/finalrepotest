resource "aws_eks_cluster" "control_plane" {
  name = var.cluster_name
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    security_group_ids = [
      aws_security_group.control_plane_security_group.id
    ]
    subnet_ids = var.cluster_subnet_ids
  }

  kubernetes_network_config {
    ip_family = "ipv4"
  }
  role_arn = aws_iam_role.service_role.arn

  tags = merge(var.common_tags,
    {
      Name = "${var.cluster_name}/ControlPlane"
  })

  version = "1.24"
}

resource "aws_eks_fargate_profile" "fargate_profiles" {
  for_each = { for k, v in var.fargate_profiles : k => v }

  cluster_name           = aws_eks_cluster.control_plane.name
  fargate_profile_name   = each.value.name
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = var.fargate_profile_subnet_ids
  dynamic "selector" {
    for_each = each.value.selectors
    content {
      namespace = selector.value.namespace
      labels    = lookup(selector.value, "labels", {})
    }
  }
  tags = merge(var.common_tags, {})
}
