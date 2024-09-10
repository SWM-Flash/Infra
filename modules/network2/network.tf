resource "aws_vpc" "cluster_vpc" {
  tags = {
    Name = "ecs-vpc-${var.env_suffix}"
  }
  cidr_block = "10.30.0.0/16"
}

data "aws_availability_zones" "available" {
}

resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.cluster_vpc.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  vpc_id                  = aws_vpc.cluster_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "ecs-public-subnet-${var.env_suffix}"
  }
}

resource "aws_internet_gateway" "cluster_igw" {
  vpc_id = aws_vpc.cluster_vpc.id

  tags = {
    Name = "ecs-igw-${var.env_suffix}"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.cluster_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster_igw.id
  }

  tags = {
    Name = "ecs-route-table-${var.env_suffix}"
  }
}

resource "aws_route_table_association" "to-public" {
  count = length(aws_subnet.public)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route.id
}
