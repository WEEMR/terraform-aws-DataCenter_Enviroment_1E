// FGTVM instance

data "aws_availability_zones" "AZs" {
  provider = aws.virginia
  state = "available"
}

// ------------------------------------------------------------------------------ Spoke 1 Interfaces

# Port 1 - WAN 1

resource "aws_network_interface" "Spoke_1_eth0_wan1" {
  provider       = aws.virginia
  description = "${var.username}_TF_Spoke_1_WAN_1"
  subnet_id   = var.spoke_1_wan1_subnet_id
  private_ips = var.spoke_1_wan1_pvt_ip
  security_groups = [var.default_SG, var.Public_SG]

  tags = {
    Name = "${var.username}_TF_Spoke_1_WAN_1"
  }
}

# Port 2 - WAN 2

resource "aws_network_interface" "Spoke_1_eth1_wan2" {
  provider       = aws.virginia
  description       = "${var.username}_TF_Spoke_1_WAN_2"
  subnet_id         = var.spoke_1_wan2_subnet_id
  private_ips       = var.spoke_1_wan2_pvt_ip
  security_groups = [var.default_SG, var.Public_SG]

  tags = {
    Name = "${var.username}_TF_Spoke_1_WAN_2"
  }
}

# Port 3 - LAN 

resource "aws_network_interface" "Spoke_1_eth2_lan" {
  provider       = aws.virginia
  description        = "${var.username}_TF_Spoke_1_LAN"
  subnet_id         = var.spoke_1_private_subnet_id
  source_dest_check = false
  private_ips        = var.spoke_1_lan_pvt_IP
  security_groups = [var.Private_SG]

  tags = {
    Name = "${var.username}_TF_Spoke_1_LAN"
  }
}

// ------------------------------------------------------------------------------ Spoke 1 Private LAN Route Table

# Assgining Spoke 1 LAN interface as the main egress point [Next Hop] for the LAN subnet.

resource "aws_route" "Spoke_1_Pvt_RT" {
  provider               = aws.virginia
  route_table_id         = var.spoke_1_pvt_rt_id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_network_interface.Spoke_1_eth2_lan]
  network_interface_id   = aws_network_interface.Spoke_1_eth2_lan.id

}

resource "aws_instance" "Spoke_1" {
  provider          = aws.virginia
  ami               = lookup(var.FGT_VM_AMI, var.virginia_region)
  instance_type     = var.FGT_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname
  user_data         = data.template_file.FortiGate.rendered

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.Spoke_1_eth0_wan1.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.Spoke_1_eth1_wan2.id
    device_index         = 1
  }

    network_interface {
    network_interface_id = aws_network_interface.Spoke_1_eth2_lan.id
    device_index         = 2
  }

  tags = {
    Name = "${var.username}_TF_Spoke_1_FGT"
  }
}


data "template_file" "FortiGate" {
  template = file(var.Spoke1_Configurations)
  vars = {
    adminsport             = "443"
    username               = "${var.username}"
    Password               = "${var.Password}"
    FMG                    = "fmg.${var.username}.fortinetpslab.com"
    Ubuntu_LAN_IP          = "${var.spoke_1_Ubuntu_LAN_IP[0]}"
    Windows_LAN_IP         = "${var.spoke_1_WinSrv_LAN_IP[0]}"
    FMG_LAN_IP             = "${var.spoke_1_FMG_LAN_IP[0]}"
    FAZ_LAN_IP             = "${var.spoke_1_FAZ_LAN_IP[0]}"
    FAC_LAN_IP             = "${var.spoke_1_FAC_LAN_IP[0]}"
    FGT_WAN_IP             = "${var.spoke_1_wan1_pvt_ip[0]}"
    FGT_WAN_2_IP           = "${var.spoke_1_wan2_pvt_ip[0]}"
    pubsub1_gw             = cidrhost(var.spoke_1_wan1_subnet_cidr, 1)
    pubsub2_gw             = cidrhost(var.spoke_1_wan2_subnet_cidr, 1)
    access_key             = "${var.access_key}"
    secret_key             = "${var.secret_key}"
    region                 = "${var.virginia_region}"
    pvt_subnet_ID          = "${var.spoke_1_private_subnet_id}"
  }
  }
