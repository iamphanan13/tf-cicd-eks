resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id
  
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}


resource "aws_subnet" "jenkins_subnet" {
  vpc_id = aws_vpc.jenkins_vpc.id 
  cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false


  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_default_route_table" "jenkins_rt" {
  default_route_table_id = aws_vpc.jenkins_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_igw.id 
  }

  tags = {
    Name = "${var.env_prefix}-route-table"
  }


}

resource "aws_instance" "jenkins_vm" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = "jenkins_ec2_kp"
  subnet_id = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids = [aws_default_security_group.jenkins_sg.id]
  availability_zone = var.availability_zone
  associate_public_ip_address = true

  # user_data = file("jenkins_scripts.sh")
  user_data = <<EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install openjdk-8-jdk -y
              sudo apt-get install wget -y
              wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
              sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
              sudo apt-get update -y
              sudo apt-get install jenkins -y
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              EOF
  tags = {
    Name = "${var.env_prefix}-jenkins-vm"
  }
}