# Key (Login)
resource "aws_key_pair" "my-key" {
  key_name   = "terra-key"
  public_key = file("C:/Users/biswa/.ssh/id_ed25519.pub")  # Corrected file path
}

# VPC
resource "aws_default_vpc" "my_vpc" {}

# Security Group
resource "aws_security_group" "my_sg" {
  name   = "terra_sg"
  vpc_id = aws_default_vpc.my_vpc.id  # interpolation

  tags = {
    Name = "terra_sg"
  }

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "my-ec2" {
  ami             = var.ec2_ami_id  # Ensure the AMI ID is correct for your region
  #count = 2 # Creating 2 instances through meta argument
  
  # Using For_each meta argument
  for_each =tomap({
    Terra-Ec2-1 = "t2.micro",
    Terra-Ec2-2 = "t2.micro"
  })
  
  # Depends_on meta argument

  depends_on = [ aws_security_group.my_sg, aws_key_pair.my-key ]



  instance_type   = each.value # var.ec2_instance_type  # variable interpolation
  key_name        = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.my_sg.name]
  
  user_data = file("install_nginx.sh")  # Corrected file path

  root_block_device { # EBS volume
    #volume_size = var.ec2_root_volume_size # variable interpolation
    
    # Using conditional expression
    volume_size = var.env=="prod" ? 20: var.ec2_default_root_volume_size
    volume_type = "gp3"
    tags={
    Name = "Terraform-EC2"
  }
  }

  tags = {
    Name = each.key
  }

}

