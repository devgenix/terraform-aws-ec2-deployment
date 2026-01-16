resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "eks-vpc", "kubernetes.io/cluster/devgenix-eks-prod" = "shared" }
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = { 
    Name = "public-${count.index}",
    "kubernetes.io/cluster/devgenix-eks-prod" = "shared",
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = { 
    Name = "private-${count.index}",
    "kubernetes.io/cluster/devgenix-eks-prod" = "shared",
    "kubernetes.io/role/internal-elb" = "1"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "gw" { vpc_id = aws_vpc.main.id }

resource "aws_eip" "nat" { vpc = true }
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}

output "vpc_id" { value = aws_vpc.main.id }
output "public_subnets" { value = aws_subnet.public[*].id }
output "private_subnets" { value = aws_subnet.private[*].id }
