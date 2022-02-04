##############################################################################################################
# Production VPC - Hub
##############################################################################################################
resource "aws_vpc" "FSA_VPC" {
  provider       = aws.fsa_1_vpc
  cidr_block           = var.fsa_1_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name            = "${var.username}_Terraform_fsa_1_Prod_VPC"
    Resources_Owner = var.username
    Enviroment      = "Terraform Production"
  }
}

// Get all avaliable AZ's in the region variable

data "aws_availability_zones" "AZs" {
  provider = aws.fsa_1_vpc
  state = "available"
}

# IGW for Public Network
resource "aws_internet_gateway" "FSA_vpc_igw" {
  provider       = aws.fsa_1_vpc
  vpc_id = aws_vpc.FSA_VPC.id
  tags = {
    Name            = "${var.username}_Terraform_fsa_1_Prod_VPC_IGW"
    Resources_Owner = var.username
    Enviroment      = "Terraform Testing"
  }
}

# Nat Gateway for Private Network

resource "aws_nat_gateway" "FSA_LAN_NATGW" {
  provider       = aws.fsa_1_vpc
  depends_on = [aws_subnet.fsa_1_private_subnet]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.fsa_1_private_subnet.id

  tags = {
    Name       = "${var.username}_Terraform_fsa_1_LAN_NAT_Gateway"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}