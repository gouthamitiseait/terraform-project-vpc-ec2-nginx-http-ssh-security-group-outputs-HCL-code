resource "aws_instance" "nginx-server" {
    ami="ami-03bb6d83c60fc5f7c"
    instance_type="t3.micro"
    subnet_id=aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-sg.id]
    associate_public_ip_address = true

    user_data = <<-EOF
#!/bin/bash
apt update -y
apt upgrade -y
apt install nginx -y
systemctl start nginx
systemctl enable nginx
EOF

    tags = {
        Name = "nginx-server"
    }
}
