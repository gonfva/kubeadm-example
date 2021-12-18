provider "aws" {
  region = var.region
}

resource "aws_vpc" "Kubeadm_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Kubeadm_vpc"
  }
}

resource "aws_subnet" "Kubeadm_subnet" {
  vpc_id            = aws_vpc.Kubeadm_vpc.id
  cidr_block        = var.subnet_cidr

  tags = {
    Name = "Kubeadm_subnet"
  }
}

resource "aws_internet_gateway" "Kubeadm_IGW" {
  vpc_id = aws_vpc.Kubeadm_vpc.id

  tags = {
    Name = "Kubeadm_IGW"
  }
}

resource "aws_default_route_table" "Kubeadm_route_table_Public" {
  default_route_table_id = aws_vpc.Kubeadm_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Kubeadm_IGW.id
  }


  tags = {
    Name = "Kubeadm_route_table_Public"
  }
}

resource "aws_security_group" "K8sSecurityGroup" {
  name        = "K8s security group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Kubeadm_vpc.id

  ingress {
    description      = "Nodeport"
    from_port        = var.nodeport
    to_port          = var.nodeport
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = [var.accessip]

  }


  ingress {
    description      = "Internal communications in the SG"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self = true

  }

  egress {
    description      = "Internal communications in the SG"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self = true

  }

  egress {
    description      = "Outflow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Outflow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "K8s security group"
  }
}

resource "aws_instance" "instances" {
  count = 3
  ami           = var.ami
  instance_type = "t3.small"
  associate_public_ip_address= true
  key_name = "k8s-keypair"
  vpc_security_group_ids = [aws_security_group.K8sSecurityGroup.id]

  subnet_id = aws_subnet.Kubeadm_subnet.id
  tags = {
    Name = var.names[count.index]
  }
}

