# ----------- VPC  ----------- #

output "AWS_US_East_VPC_ID" {
    value = module.Prod_VPC.SDWAN_VPC
}

# ----------- Spoke 1  ----------- #

output "spoke_1_WAN_1_EIP" {
  value       = module.Spoke_1.Spoke_1_WAN1
}

output "spoke_1_WAN_2_EIP" {
  value       = module.Spoke_1.Spoke_1_WAN2
}

output "Spoke1_FGT_DNS_Name" {
  value = module.Spoke_1.Spoke1_FGT_DNS_Name
}

output "Spoke1_Linux_DNS_Name" {
  value = module.Spoke_1.Spoke1_Linux_DNS_Name
}

output "Spoke1_Windows_DNS_Name" {
  value = module.Spoke_1.Spoke1_Windows_Public
}

output "Spoke1_Windows_Password" {
  value = module.Spoke_1.Spoke1_Windows_Password
}