output "ec2_public_ip" {
  value = aws_instance.jenkins_vm.public_ip
  
}

output "ec2_private_ip" {
  value = aws_instance.jenkins_vm.private_ip
}

output "my_ipv4" {
  value = data.http.my_ipv4.response_body
  
}