# Criando o Security Group de subnet pública

resource "aws_security_group" "security-group-avg-publica" {

  name   = var.nome_security_group_subnet_publica
  vpc_id = aws_vpc.vpc-avg-devopspro.id

  # Garantindo as configurações de Firewall Security Group Inbound

  dynamic "ingress" {

    for_each = var.regras_fw_sg_subnet_publica_ingresses
    content {

      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]

    }

  }

  # Garantindo as configurações de Firewall Security Group Oubound

  dynamic "egress" {

    for_each = var.regras_fw_sg_subnet_publica_egresses
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
    Name = var.nome_security_group_subnet_publica
  }

}


# Criando a Network ACL Subnet AVG Pública

resource "aws_network_acl" "network-acl-avg-publica" {
  vpc_id     = aws_vpc.vpc-avg-devopspro.id
  subnet_ids = [aws_subnet.subnet-avg-publica.id]

  # Garantindo as configurações de Network ACL de Inbound

  dynamic "ingress" {

    for_each = var.regras_acl_subnet_publica_ingresses
    content {

      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]

    }

  }

  # Garantindo as configurações de Network ACL Outbound

  dynamic "egress" {

    for_each = var.regras_acl_subnet_publica_egresses
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
    Name = var.nome_acl_subnet_publica
  }

}


# Criando o Security Group de subnet privada

resource "aws_security_group" "security-group-avg-privada" {
  name        = "security-group-avg-privada"
  description = "Regas de Firewall para as EC2 de banco de dados"
  vpc_id      = aws_vpc.vpc-avg-devopspro.id

  # Garantindo as configurações de Firewall Security Group Inbound

  # SSH
  ingress {
    description = "Acesso SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-avg-devopspro.cidr_block]
  }

  # MongoDB
  ingress {
    description     = "Acesso MongoDB"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.security-group-avg-publica.id]
  }

  # Garantindo as configurações de Firewall Security Group Oubound

  dynamic "egress" {

    for_each = var.regras_fw_sg_subnet_privada_egresses
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
    Name = var.nome_security_group_subnet_privada
  }


}



# Criando a Network ACL Subnet AVG Privada

resource "aws_network_acl" "network-acl-avg-privada" {
  vpc_id     = aws_vpc.vpc-avg-devopspro.id
  subnet_ids = [aws_subnet.subnet-avg-privada.id]

  # Garantindo as configurações de Network ACL de Inbound

  dynamic "ingress" {

    for_each = var.regras_acl_subnet_privada_ingresses
    content {

      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]

    }

  }


  # Garantindo as configurações de Network ACL Outbound

  dynamic "egress" {

    for_each = var.regras_acl_subnet_privada_egresses
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
    Name = var.nome_acl_subnet_privada
  }

}