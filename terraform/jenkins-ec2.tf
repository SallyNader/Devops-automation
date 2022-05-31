resource "aws_instance" "jenkins" {
  ami                    = "ami-0022f774911c1d690"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("../bash/install-jenkins.sh")
  tags = {
    name = "jenkins"
  }
  key_name = aws_key_pair.key.id
}


resource "aws_security_group" "web" {
  name        = "Allow web traffic"
  description = "Allow Web inbound and outbound traffic"

  ingress {
    description      = "Allow ssh from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow http from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow TLS from everywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web_traffic"
  }
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}

resource "aws_key_pair" "key" {
  public_key = file("~/.ssh/id_rsa.pub")
}
