#
#
#  Variáveis do Projeto
#
#

variable "project_region" {
  type        = string
  default     = "us-east-1"
  description = "Região do Projeto"
}

#
#
#  Variáveis da VPC
#
#

variable "avg_vpc_name" {
  type        = string
  default     = "avg-vpc"
  description = "Nome da VPC"
}

variable "avg_vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr block da VPC"
}

variable "avg_subnet_publica_name" {
  type        = string
  default     = "avg-subnet-publica"
  description = "Nome da subnet publica"
}

variable "avg_subnet_publica_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "cidr block da subnet publica"
}

variable "avg_subnet_privada_name" {
  type        = string
  default     = "avg-subnet-privada"
  description = "Nome da subnet privada"
}

variable "avg_subnet_privada_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "cidr block da subnet privada"
}

variable "avg_igw_name" {
  type        = string
  default     = "avg-igw"
  description = "Nome do internet gateway"
}

variable "avg_nat_eip_name" {
  type        = string
  default     = "avg-nat-eip"
  description = "Nome do elastic ip vinculado ao nat gateway"
}

variable "avg_nat_gtw_name" {
  type        = string
  default     = "avg-nat-gtw"
  description = "Nome do nat gateway"
}

variable "avg_rt_publica_name" {
  type        = string
  default     = "avg-rt-publica"
  description = "Nome da route table publica"
}

variable "avg_rt_privada_name" {
  type        = string
  default     = "avg-rt-privada"
  description = "Nome da route table privada"
}

#
#
#  Variáveis das EC2
#
#
variable "kpair_ssh_name" {
  type        = string
  default     = "handson-labs-key"
  description = "description"
}

variable "kpair_ssh_file" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "description"
}

variable "ec2_ami" {
  type        = string
  default     = "ami-053b0d53c279acc90"
  description = "description"
}

variable "web_ec2_name" {
  type        = string
  default     = "web-ec2"
  description = "description"
}

variable "web_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "description"
}


variable "db_ec2_name" {
  type        = string
  default     = "db-ec2"
  description = "description"
}

variable "db_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "description"
}

#
#
#  Variáveis de segurança
#
#

variable "avg_sg_web_name" {
  type        = string
  default     = "avg-sg-web"
  description = "Nome do security group para a máquina de aplicação WEB"
}

variable "avg_sg_web_ingresses" {
  default = [
    {
      description      = "Acesso HTTP",
      from_port        = 80,
      to_port          = 80,
      protocol         = "tcp",
      cidr_blocks      = ["0.0.0.0/0"],
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Nome do security group para a máquina de aplicação WEB"
}

variable "avg_sg_web_egresses" {
  default = [
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso MongoDB"
      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Nome do security group para a máquina de aplicação WEB"
}

variable "avg_nacl_publica_name" {
  type        = string
  default     = "avg-nacl-publica"
  description = "Nome da Network ACL para a subnet publica"
}

variable "avg_nacl_publica_ingress" {
  default = [
    # HTTP
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    # HTTPs
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    # SSH
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    },
    # Portas efemeras
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas DNS
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS
    {
      protocol   = "udp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    }
  ]
  description = "Regras de ingress da Network ACL para a subnet publica"
}

variable "avg_nacl_publica_egress" {
  default = [
    # Portas efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    # Portas DNS
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS
    {
      protocol   = "udp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas SSH
    {
      protocol   = "tcp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    }
  ]
  description = "Regras de egress da Network ACL para a subnet publica"
}

variable "avg_sg_db_name" {
  type        = string
  default     = "avg-sg-db"
  description = "Nome do security group para a máquina do MongoDB"
}

variable "avg_sg_db_egresses" {
  default = [
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Nome do security group para a máquina do MongoDB"
}

variable "avg_nacl_privada_name" {
  type        = string
  default     = "avg-nacl-privada"
  description = "Nome da Network ACL para a subnet privada"
}

variable "avg_nacl_privada_ingress" {
  default = [
    # MongoDB
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 27017
      to_port    = 27017
    },
    # SSH
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    },
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    }
  ]
  description = "Regras de ingress da Network ACL para a subnet privada"
}

variable "avg_nacl_privada_egress" {
  default = [
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    # Portas DNS
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS
    {
      protocol   = "udp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    }
  ]
  description = "Regras de egress da Network ACL para a subnet privada"
}