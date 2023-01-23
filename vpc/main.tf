provider "aws" {
  region = var.region
}

resource "aws_vpc" "ts-16300419-ESG-VPC" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = "ts-16300419-ESG-VPC"
    env = "cp-dev"
  }
}

##### Control Plane Dev #######

##### Public Subnet ########
resource "aws_subnet" "ts-16300419-ESG-cp-dev-pubic-sub-1" {
  vpc_id                  = aws_vpc.ts-16300419-ESG-VPC.id
  cidr_block              = var.subnet_cidr_block_1
  
  availability_zone       = var.subnet_availability_zone_env_1
  

  tags = {
    Name = "ts-16300419-ESG-cp-dev-pubic-sub-1"
    env = "cp-dev"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "ts-16300419-ESG-cp-dev-pubic-sub-2" {
  vpc_id                  = aws_vpc.ts-16300419-ESG-VPC.id
  cidr_block              = var.subnet_cidr_block_2
  
  availability_zone       = var.subnet_availability_zone_env_2
  

  tags = {
    Name = "ts-16300419-ESG-cp-dev-pubic-sub-2"
    env = "cp-dev"
    "kubernetes.io/role/elb" = "1"
  }
}

########## IGW ################
resource "aws_internet_gateway" "ts-16300419-ESG-IGW" {
  vpc_id = aws_vpc.ts-16300419-ESG-VPC.id

  tags = {
    Name = "ts-16300419-ESG-IGW"
    env = "cp-dev"
  }
}

########## Route table #############

resource "aws_route_table" "ts-16300419-ESG-public-RT" {
  vpc_id = aws_vpc.ts-16300419-ESG-VPC.id

  route {
    cidr_block = var.route_cidr
    
    gateway_id = aws_internet_gateway.ts-16300419-ESG-IGW.id
  }

  tags = {
    Name = "ts-16300419-ESG-public-RT"
    env = "cp-dev"
  }
}

########## Route table Association  ###########

resource "aws_route_table_association" "ts-16300419-ESG-public-RT-1" {
  subnet_id      = aws_subnet.ts-16300419-ESG-cp-dev-pubic-sub-1.id
  route_table_id = aws_route_table.ts-16300419-ESG-public-RT.id
}

resource "aws_route_table_association" "ts-16300419-ESG-public-RT-2" {
  subnet_id      = aws_subnet.ts-16300419-ESG-cp-dev-pubic-sub-2.id
  route_table_id = aws_route_table.ts-16300419-ESG-public-RT.id
}

###### NACl ######

resource "aws_network_acl" "ts-16300419-ESG-public-nacl" {
  vpc_id = aws_vpc.ts-16300419-ESG-VPC.id
  subnet_ids = [ aws_subnet.ts-16300419-ESG-cp-dev-pubic-sub-1.id, aws_subnet.ts-16300419-ESG-cp-dev-pubic-sub-2.id  ]

# allow ingress port all port
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # allow egress port all port
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  
tags = {
    Name = "ts-16300419-ESG-public-nacl"
    env = "cp-dev"
  }
}
  
  
########## Private subnet ###########

resource "aws_subnet" "ts-16300419-ESG-cp-dev-private-sub-1" {
  vpc_id                  = aws_vpc.ts-16300419-ESG-VPC.id
  cidr_block              = var.private_subnet_cidr_block_3  

  availability_zone       = var.subnet_availability_zone_env_1
  

  tags = {
    Name = "ts-16300419-ESG-cp-dev-private-sub-1"
    env = "cp-dev"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "ts-16300419-ESG-cp-dev-private-sub-2" {
  vpc_id                  = aws_vpc.ts-16300419-ESG-VPC.id
  cidr_block              = var.private_subnet_cidr_block_4 

  availability_zone       = var.subnet_availability_zone_env_2
  

  tags = {
    Name = "ts-16300419-ESG-cp-dev-private-sub-2"
    env = "cp-dev"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

############# Route Table ############

resource "aws_route_table" "ts-16300419-ESG-private-RT" {
  vpc_id = aws_vpc.ts-16300419-ESG-VPC.id

  #route {
  #  cidr_block = var.route_cidr
    
  #  gateway_id = aws_transit_gateway.ts-16300419-ESG-TGW
  #}

  tags = {
    Name = "ts-16300419-ESG-private-RT"
    env = "cp-dev"
  }
}

####### Route table Association ###############

resource "aws_route_table_association" "ts-16300419-ESG-private-RT-1" {
  subnet_id      = aws_subnet.ts-16300419-ESG-cp-dev-private-sub-1.id
  route_table_id = aws_route_table.ts-16300419-ESG-private-RT.id
}

resource "aws_route_table_association" "ts-16300419-ESG-private-RT-2" {
  subnet_id      = aws_subnet.ts-16300419-ESG-cp-dev-private-sub-2.id
  route_table_id = aws_route_table.ts-16300419-ESG-private-RT.id
}

###### NACl ######

resource "aws_network_acl" "ts-16300419-ESG-private-nacl" {
  vpc_id = aws_vpc.ts-16300419-ESG-VPC.id
  subnet_ids = [ aws_subnet.ts-16300419-ESG-cp-dev-private-sub-1.id, aws_subnet.ts-16300419-ESG-cp-dev-private-sub-2.id  ]

# allow ingress port all port
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # allow egress port all port
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  
tags = {
    Name = "ts-16300419-ESG-private-nacl"
    env = "cp-dev"
  }
}
