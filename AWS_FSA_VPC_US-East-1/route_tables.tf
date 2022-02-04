// Virgina Public Route Table  (Main / Default Route Table)

resource "aws_default_route_table" "public_subnet_RT" {
  provider       = aws.fsa_1_vpc
  default_route_table_id = aws_vpc.FSA_VPC.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.FSA_vpc_igw.id
  }

  tags = {
    Name       = "${var.username}_Terraform_fsa_1_public_subnets_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
    Region     = "US East 1"
  }
}



resource "aws_route_table" "private_subnet_RT" {
  provider       = aws.fsa_1_vpc
  vpc_id = aws_vpc.FSA_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.FSA_LAN_NATGW.id
  }

  tags = {
    Name       = "${var.username}_Terraform_fsa_1_private_subnets_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
    Region     = "US East 1"
  }
}

// fsa 1 Private Subnet Route Table

resource "aws_route_table" "fsa_1_HA_pvt_rt" {
  provider       = aws.fsa_1_vpc
  vpc_id = aws_vpc.FSA_VPC.id

  tags = {
    Name       = "${var.username}_fsa_1_HA_pvt_rt"
    reference  = "fsa_1_HA_pvt_rt"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}