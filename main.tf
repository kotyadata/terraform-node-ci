provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "node_app" {
  ami           = "ami-0dee22c13ea7a9a67" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "jenkins_ec2_key"       # Optional

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo systemctl start docker
    sudo docker run -d -p 80:3000 66106/node-docker-app:latest
  EOF

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "NodeAppDocker"
  }
}
