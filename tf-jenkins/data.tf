data "aws_ami" "amz-linux-2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  owners = ["amazon"] # Canonical
}


data "http" "my_ipv4" {
  url = "http://ipv4.icanhazip.com"
}