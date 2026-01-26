provider "aws" {
  region = "us-east-1"
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins"
  description = "Allow SSH and Jenkins"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

# -------------------------
# Jenkins
# -------------------------
resource "aws_instance" "jenkins" {
  ami           = "ami-0220d79f3f480ecf5" # Amazon Linux 2 (us-east-1)
  instance_type = "t3.small"
  security_groups = [aws_security_group.jenkins_sg.name]
  user_data = file("jenkins.sh")
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = {
    Name = "Jenkins"
    }
  }
  tags = {
    Name = "jenkins"
  }
}

# -------------------------
# Jenkins Agent
# -------------------------
resource "aws_instance" "jenkins_agent" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.small"
  security_groups = [aws_security_group.jenkins_sg.name]
  user_data = file("jenkins.sh")
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = {
    Name = "Jenkins-agent"
    }
  }


  tags = {
    Name = "jenkins-agent"
  }
}
