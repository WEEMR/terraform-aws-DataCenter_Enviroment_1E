module "FSA_1" {
  source                       = "./AWS_FSA_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  Password                     = var.Password
  keyname                      = var.keyname
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone
  Public_SubHosted_Zone_id       = module.Prod_VPC.Public_SubHosted_Zone_id


  # VPC CIDR & Subnets

  fsa_1_vpc_cidr                = var.fsa_1_vpc_cidr
  # FSA 1
  fsa_1_public_subnet_cidr      = var.fsa_1_public_subnet_cidr
  fsa_1_private_subnet_cidr      = var.fsa_1_private_subnet_cidr
  fsa_1_HA_subnet_cidr        = var.fsa_1_HA_subnet_cidr

  # FSA Interface IPs

  fsa_1_wan_pvt_ip            = var.fsa_1_wan_pvt_ip
  fsa_1_lan_pvt_ip            = var.fsa_1_lan_pvt_ip
  fsa_1_ha_pvt_IP             = var.fsa_1_ha_pvt_IP
}


module "Prod_VPC" {
  source          = "./AWS_VPC_US-East-1"
  access_key      = var.access_key
  secret_key      = var.secret_key
  username        = var.username
  virginia_region = var.virginia_region
  Public_Hosted_Zone = var.Public_Hosted_Zone
  SubHosted_Zone = var.SubHosted_Zone

  # VPC CIDR & Subnets

  prod_vpc_cidr          = var.prod_vpc_cidr
  # Spoke 1
  spoke_1_wan1_subnet_cidr       = var.spoke_1_wan1_subnet_cidr
  spoke_1_wan2_subnet_cidr       = var.spoke_1_wan2_subnet_cidr
  spoke_1_private_subnet_cidr    = var.spoke_1_private_subnet_cidr
  # Spoke 2

}

module "Spoke_1" {
  source                   = "./Spoke_1"
  access_key               = var.access_key
  secret_key               = var.secret_key

  # Global dependencies

  username                 = var.username
  Password                 = var.Password
  keyname                  = var.keyname
  virginia_region          = var.virginia_region
  Public_SubHosted_Zone_id = module.Prod_VPC.Public_SubHosted_Zone_id

  # Security Groups 
  
  default_SG                = module.Prod_VPC.default_SG
  Public_SG                 = module.Prod_VPC.Public_SG
  Private_SG                = module.Prod_VPC.Private_SG
  
  # Spoke 1 Specific dependencies

  spoke_1_wan1_subnet_cidr       = var.spoke_1_wan1_subnet_cidr
  spoke_1_wan2_subnet_cidr       = var.spoke_1_wan2_subnet_cidr
  spoke_1_private_subnet_cidr    = var.spoke_1_private_subnet_cidr

  spoke_1_wan1_subnet_id    = module.Prod_VPC.spoke_1_wan1_subnet_id
  spoke_1_wan2_subnet_id    = module.Prod_VPC.spoke_1_wan2_subnet_id
  spoke_1_private_subnet_id = module.Prod_VPC.spoke_1_private_subnet_id
  spoke_1_pvt_rt_id         = module.Prod_VPC.spoke_1_pvt_rt_id


  # FGT, Ubuntu and Windows Private IPs

  spoke_1_wan1_pvt_ip       = var.spoke_1_wan1_pvt_ip
  spoke_1_wan2_pvt_ip       = var.spoke_1_wan2_pvt_ip
  spoke_1_lan_pvt_IP        = var.spoke_1_lan_pvt_IP
  spoke_1_Ubuntu_LAN_IP     = var.spoke_1_Ubuntu_LAN_IP
  spoke_1_WinSrv_LAN_IP     = var.spoke_1_WinSrv_LAN_IP
  spoke_1_FMG_LAN_IP          = var.spoke_1_FMG_LAN_IP
  spoke_1_FAZ_LAN_IP          = var.spoke_1_FAZ_LAN_IP
  spoke_1_FAC_LAN_IP          = var.spoke_1_FAC_LAN_IP

}