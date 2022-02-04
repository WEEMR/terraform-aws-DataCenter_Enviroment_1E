// -------------------------------------------------------------------------------------------------------------  Subnets 

// ------------------------------------------------------------------------------ fsa 1 Subnets

// fsa 1 Public Subnet 1

resource "aws_subnet" "fsa_1_public_subnet" {
  provider          = aws.fsa_1_vpc
  vpc_id            = aws_vpc.FSA_VPC.id
  cidr_block        = var.fsa_1_public_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_fsa_1_public_1"
    reference  = "fsa_1_wan1_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// -------------------------- fsa 1 Public Subnet Association with RT

resource "aws_route_table_association" "fsa_1_public_RT_association" {
  provider       = aws.fsa_1_vpc
  subnet_id      = aws_subnet.fsa_1_public_subnet.id
  route_table_id = aws_default_route_table.public_subnet_RT.id
}



// fsa 1 Public Subnet 2

resource "aws_subnet" "fsa_1_private_subnet" {
  provider          = aws.fsa_1_vpc
  vpc_id            = aws_vpc.FSA_VPC.id
  cidr_block        = var.fsa_1_private_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_fsa_1_private_subnet"
    reference  = "fsa_1_wan2_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_route_table_association" "fsa_1_private_RT_association" {
  provider       = aws.fsa_1_vpc
  subnet_id      = aws_subnet.fsa_1_private_subnet.id
  route_table_id = aws_route_table.private_subnet_RT.id
}


// fsa 1 Private Subnet

resource "aws_subnet" "fsa_1_HA_subnet" {
  provider          = aws.fsa_1_vpc
  vpc_id            = aws_vpc.FSA_VPC.id
  cidr_block        = var.fsa_1_HA_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_fsa_1_HA_Subnet"
    reference  = "fsa_1_private_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"

  }
}

// -------------------------- fsa 1 HA Subnet Association with RT


// Virginia Private Subnet 1 Association 

resource "aws_route_table_association" "fsa_1_HA_RT_association" {
  provider       = aws.fsa_1_vpc
  subnet_id      = aws_subnet.fsa_1_HA_subnet.id
  route_table_id = aws_route_table.fsa_1_HA_pvt_rt.id
}