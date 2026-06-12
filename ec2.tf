data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

resource "aws_instance" "nginx-server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx
EOF
}
