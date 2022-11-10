variable "vpcConfig" {
  type = object({
    name                 = string
    cird                 = string
    region               = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    public_subnet_a = object({
      name                    = string
      cird                    = string
      map_public_ip_on_launch = bool
    })
    public_subnet_b = object({
      name                    = string
      cird                    = string
      map_public_ip_on_launch = bool
    })
    public_subnet_c = object({
      name                    = string
      cird                    = string
      map_public_ip_on_launch = bool
    })
    private_subnet_a = object({
      name                    = string
      cird                    = string
      map_public_ip_on_launch = bool
    })
    private_subnet_b = object({
      name                    = string
      cird                    = string
      map_public_ip_on_launch = bool
    })
    private_subnet_c = object({
      name                    = string
      cird                    = string
      map_public_ip_on_launch = bool
    })
  })
  default = {
    name                 = "main-vpc"
    cird                 = "10.0.0.0/16"
    region               = "us-east-1"
    enable_dns_support   = true
    enable_dns_hostnames = true
    public_subnet_a = {
      name                    = "public-subnet-a"
      cird                    = "10.0.0.0/24"
      map_public_ip_on_launch = true
    }
    public_subnet_b = {
      name                    = "public-subnet-b"
      cird                    = "10.0.1.0/24"
      map_public_ip_on_launch = true
    }
    public_subnet_c = {
      name                    = "public-subnet-c"
      cird                    = "10.0.2.0/24"
      map_public_ip_on_launch = true
    }
    private_subnet_a = {
      name                    = "private-subnet-a"
      cird                    = "10.0.16.0/20"
      map_public_ip_on_launch = false
    }
    private_subnet_b = {
      name                    = "private-subnet-b"
      cird                    = "10.0.32.0/20"
      map_public_ip_on_launch = false
    }
    private_subnet_c = {
      name                    = "private-subnet-c"
      cird                    = "10.0.48.0/20"
      map_public_ip_on_launch = false
    }
  }
}


resource "aws_vpc" "vpc_1" {
  cidr_block           = var.vpcConfig.cird
  enable_dns_support   = var.vpcConfig.enable_dns_support
  enable_dns_hostnames = var.vpcConfig.enable_dns_hostnames
  tags = {
    "Name" = var.vpcConfig.name
  }
}


resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.vpcConfig.public_subnet_a.cird
  availability_zone       = "${var.vpcConfig.region}a"
  map_public_ip_on_launch = var.vpcConfig.public_subnet_a.map_public_ip_on_launch
  tags = {
    "Name" = var.vpcConfig.public_subnet_a.name
  }
  depends_on = [
    aws_vpc.vpc_1
  ]

}


resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.vpcConfig.public_subnet_b.cird
  availability_zone       = "${var.vpcConfig.region}b"
  map_public_ip_on_launch = var.vpcConfig.public_subnet_b.map_public_ip_on_launch
  tags = {
    "Name" = var.vpcConfig.public_subnet_b.name
  }
  depends_on = [
    aws_vpc.vpc_1
  ]

}


resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.vpcConfig.public_subnet_c.cird
  availability_zone       = "${var.vpcConfig.region}c"
  map_public_ip_on_launch = var.vpcConfig.public_subnet_c.map_public_ip_on_launch
  tags = {
    "Name" = var.vpcConfig.public_subnet_c.name
  }
  depends_on = [
    aws_vpc.vpc_1
  ]

}

resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.vpcConfig.private_subnet_a.cird
  availability_zone       = "${var.vpcConfig.region}a"
  map_public_ip_on_launch = var.vpcConfig.private_subnet_a.map_public_ip_on_launch
  tags = {
    "Name" = var.vpcConfig.private_subnet_a.name
  }
  depends_on = [
    aws_vpc.vpc_1
  ]

}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.vpcConfig.private_subnet_b.cird
  availability_zone       = "${var.vpcConfig.region}b"
  map_public_ip_on_launch = var.vpcConfig.private_subnet_b.map_public_ip_on_launch
  tags = {
    "Name" = var.vpcConfig.private_subnet_b.name
  }
  depends_on = [
    aws_vpc.vpc_1
  ]

}

resource "aws_subnet" "private_subnet_c" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.vpcConfig.private_subnet_c.cird
  availability_zone       = "${var.vpcConfig.region}c"
  map_public_ip_on_launch = var.vpcConfig.private_subnet_c.map_public_ip_on_launch
  tags = {
    "Name" = var.vpcConfig.private_subnet_c.name
  }
  depends_on = [
    aws_vpc.vpc_1
  ]

}

output "vpc_1_id" {
  value = aws_vpc.vpc_1.id
}

output "vpc_1_cird" {
  value = aws_vpc.vpc_1.cidr_block
}

output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.public_subnet_b.id
}

output "public_subnet_c_id" {
  value = aws_subnet.public_subnet_c.id
}

output "private_subnet_a_id" {
  value = aws_subnet.private_subnet_a.id
}

output "private_subnet_b_id" {
  value = aws_subnet.private_subnet_b.id
}

output "private_subnet_c_id" {
  value = aws_subnet.private_subnet_c.id
}


