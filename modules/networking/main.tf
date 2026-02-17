# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "gaurav-landing-zone-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public-route-table"
  }
}

# Route to Internet
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_assoc" {
  count          = 2
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "gaurav-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-route-table"
  }
}

# Route private subnet traffic to NAT
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate private subnets
resource "aws_route_table_association" "private_assoc" {
  count          = 2
  subnet_id      =var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}