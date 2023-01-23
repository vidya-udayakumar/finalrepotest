resource "aws_security_group" "cluster_shared_node_security_group" {
  description = "Communication between all nodes in the cluster"
  tags = merge(var.common_tags, {
    Name = "eks-${var.cluster_name}-cluster/ClusterSharedNodeSecurityGroup"
  })
  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  vpc_id = var.vpc_id
}


resource "aws_security_group" "control_plane_security_group" {
  description = "Communication between the control plane and worker nodegroups"
  tags = merge(var.common_tags, {
    Name = "eks-${var.cluster_name}-cluster/ControlPlaneSecurityGroup"
  })
  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  vpc_id = var.vpc_id
}
