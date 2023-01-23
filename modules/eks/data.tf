data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "tls_certificate" "control_plane_crt" {
  url = aws_eks_cluster.control_plane.identity[0].oidc[0].issuer
}
