// ------------------------------- VPC

output "FSA_VPC" {
  value       = aws_vpc.FSA_VPC.id
}

output "fsa_eip" {
  value       = aws_eip.fsa_1_wan.public_ip
}
