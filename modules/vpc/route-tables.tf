# =====================================================
# PUBLIC ROUTE TABLE
# Public NLB + Web Servers
# =====================================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
  }
}

# Public Subnet Associations

resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# Web Subnet Associations

resource "aws_route_table_association" "web_az1" {
  subnet_id      = aws_subnet.web_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "web_az2" {
  subnet_id      = aws_subnet.web_az2.id
  route_table_id = aws_route_table.public.id
}

# =====================================================
# PRIVATE ROUTE TABLE
# App Servers + DB
# =====================================================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  
   route {
     cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
   }

  tags = {
    Name        = "${var.environment}-private-rt"
    Environment = var.environment
  }
}

# App Subnet Associations

resource "aws_route_table_association" "app_az1" {
  subnet_id      = aws_subnet.app_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "app_az2" {
  subnet_id      = aws_subnet.app_az2.id
  route_table_id = aws_route_table.private.id
}

# DB Subnet Associations

resource "aws_route_table_association" "db_az1" {
  subnet_id      = aws_subnet.db_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db_az2" {
  subnet_id      = aws_subnet.db_az2.id
  route_table_id = aws_route_table.private.id
}