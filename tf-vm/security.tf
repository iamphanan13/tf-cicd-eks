# Security group for Jenkins server
resource "aws_default_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.jenkins_vpc.id

  // Allow SSH to VM
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ipv4.response_body)}/32"]

  }
  # Allow Jenkins port
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  // Allow all outbound traffic to any destination 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "${var.env_prefix}-default-security_group"
  }
}