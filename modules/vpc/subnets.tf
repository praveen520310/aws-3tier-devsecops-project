# ---------------------------
# Public subnets
# ---------------------------
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-az1"
    Tier = "public"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-az2"
    Tier = "public"
  }
}

# ---------------------------
# Web tier subnets
# ---------------------------
resource "aws_subnet" "web_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.environment}-web-az1"
    Tier = "web"
  }
}

resource "aws_subnet" "web_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.environment}-web-az2"
    Tier = "web"
  }
}

# ---------------------------
# App tier subnets
# ---------------------------
resource "aws_subnet" "app_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.environment}-app-az1"
    Tier = "app"
  }
}

resource "aws_subnet" "app_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.environment}-app-az2"
    Tier = "app"
  }
}

# ---------------------------
# DB tier subnets
# ---------------------------
resource "aws_subnet" "db_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-db-az1"
    Tier = "db"
  }
}

resource "aws_subnet" "db_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-db-az2"
    Tier = "db"
  }
}