output "ec2_public_ip" {
  value = aws_instance.jenkins_vm.public_ip
}