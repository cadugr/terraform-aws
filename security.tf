resource "aws_security_group" "avg_sg_web" {
  name        = var.avg_sg_web_name
  description = "Regras de firewall para as EC2 para aplicacao Web"
  vpc_id      = aws_vpc.avg_vpc.id

  dynamic "ingress" {
    for_each = var.avg_sg_web_ingresses
    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.avg_sg_web_egresses
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
    }
  }

  tags = {
    Name = var.avg_sg_web_name
  }
}

resource "aws_network_acl" "avg_nacl_publica" {
  vpc_id     = aws_vpc.avg_vpc.id
  subnet_ids = [aws_subnet.avg_subnet_publica.id]

  dynamic "ingress" {
    for_each = var.avg_nacl_publica_ingress
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.avg_nacl_publica_egress
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  tags = {
    Name = var.avg_nacl_publica_name
  }
}

resource "aws_security_group" "avg_sg_db" {
  name        = var.avg_sg_db_name
  description = "Regras de firewall para as EC2 para o banco de dados"
  vpc_id      = aws_vpc.avg_vpc.id

  ingress {
    description     = "Acesso MongoDB"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.avg_sg_web.id]
  }

  ingress {
    description = "Acesso SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.avg_vpc.cidr_block]
  }

  dynamic "egress" {
    for_each = var.avg_sg_db_egresses
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
    }
  }

  tags = {
    Name = var.avg_sg_db_name
  }
}

resource "aws_network_acl" "avg_nacl_privada" {
  vpc_id     = aws_vpc.avg_vpc.id
  subnet_ids = [aws_subnet.avg_subnet_privada.id]

  dynamic "ingress" {
    for_each = var.avg_nacl_privada_ingress
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.avg_nacl_privada_egress
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  tags = {
    Name = var.avg_nacl_privada_name
  }

}