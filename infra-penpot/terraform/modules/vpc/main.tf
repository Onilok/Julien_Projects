resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# --------- Subnets publics ---------
resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${var.azs[count.index]}-az${count.index + 1}"
  }
}

# --------- Subnets privés ---------
resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-private-${var.azs[count.index]}-az${count.index + 1}"
  }
}

# --------- Subnets privés (private_stg) ---------
resource "aws_subnet" "private_stg" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_secondary_cidrs[count.index] # Staging CIDR subnet
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-private-stg-${var.azs[count.index]}-az${count.index + 1}"
  }
}

# --------- Route table publique ---------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# --------- Association du subnet public à la route table public ---------
resource "aws_route_table_association" "public" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# --------- Route table privée unique ---------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# --------- Association des subnets private_stg à la route table privée ---------
resource "aws_route_table_association" "private_stg" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private_stg[count.index].id
  route_table_id = aws_route_table.private.id
}
