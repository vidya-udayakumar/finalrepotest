output "acontrol_plane_crt_no" {
  value = data.tls_certificate.control_plane_crt.url
}

output "identity_id" {
  value = local.identity_id
}

output "arn" {
  value = aws_eks_cluster.control_plane.arn
}

output "certificate_authority_data" {
  value = aws_eks_cluster.control_plane.certificate_authority
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.control_plane.cluster_id
}

output "cluster_name" {
  value = var.cluster_name
}

output "endpoint" {
  value = aws_eks_cluster.control_plane.endpoint
}

output "fargate_pod_execution_role_arn" {
  value = aws_iam_role.fargate_pod_execution_role.arn
}

output "security_group" {
  value = aws_security_group.control_plane_security_group.id
}

output "service_role_arn" {
  value = aws_iam_role.service_role.arn
}

output "shared_node_security_group" {
  value = aws_security_group.cluster_shared_node_security_group.id
}

output "role1" {
  value = aws_iam_role.service_account_role
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}


