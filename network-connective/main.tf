variable "vpc_1_id" {
  type = string
}

variable "vpc_1_cird" {
  type = string
}

variable "public_subnets" {
  type = list(string)

}

variable "private_subnets" {
  type = list(string)

}

variable "igw_name" {
  type    = string
  default = "main-igw"

}

resource "aws_internet_gateway" "igw_1" {
  vpc_id = var.vpc_1_id
  tags = {
    "Name" = var.igw_name
  }

}

resource "aws_eip" "eip_nat_gw" {
  count     = length(var.public_subnets)
  vpc      = true
  depends_on = [
    aws_internet_gateway.igw_1
  ]
}

resource "aws_nat_gateway" "nat_gws" {
  count     = length(var.public_subnets)
  subnet_id = var.public_subnets[count.index]
  allocation_id = aws_eip.eip_nat_gw[count.index].id
  tags = {
    "Name" = "nat-gw-${count.index}"
  }
  depends_on = [
    aws_internet_gateway.igw_1,
    aws_eip.eip_nat_gw
  ]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_1_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1.id
  }
  tags = {
    "Name" = "public-route"
  }
  depends_on = [
    aws_internet_gateway.igw_1
  ]
}

resource "aws_route_table" "pivate_route_tables" {
  count  = length(aws_nat_gateway.nat_gws)
  vpc_id = var.vpc_1_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gws[count.index].id
  }
  tags = {
    "Name" = "private-route-${count.index}"
  }
  depends_on = [
    aws_nat_gateway.nat_gws
  ]

}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnets)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = var.public_subnets[count.index]
  depends_on = [
    aws_route_table.public_route_table
  ]

}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnets)
  route_table_id = aws_route_table.pivate_route_tables[count.index % length(aws_route_table.pivate_route_tables)].id
  subnet_id      = var.private_subnets[count.index]
  depends_on = [
    aws_route_table.pivate_route_tables
  ]

}


