#
# Variáveis Escopo do Região do Projeto
#

variable "region_projeto_avg" {

  type        = string
  default     = "us-east-1"
  description = "Região utilizada no Projeto AVG"

}

#
# Variáveis Escopo do VPC
#

variable "nome_vpc_projeto_avg" {

  type        = string
  default     = "vpc-avg-devopspro"
  description = "Nome da VPC do Projeto AVG"

}

variable "cidr_block_vpc_avg" {

  type        = string
  default     = "10.0.0.0/16"
  description = "Range do Cidr Block da VPC do Projeto AVG"

}


#
# Variáveis Escopo do Subnets
#

variable "nome_subnet_publica" {

  type        = string
  default     = "subnet-avg-publica"
  description = "Nome da Subnet Pública do Projeto AVG"

}

variable "cidr_block_subnet_publica" {

  type        = string
  default     = "10.0.1.0/24"
  description = "Range IP da Subnet Pública do Projeto AVG"

}

variable "nome_subnet_privada" {

  type        = string
  default     = "subnet-avg-privada"
  description = "Nome da Subnet Privada do Projeto AVG"

}

variable "cidr_block_subnet_privada" {

  type        = string
  default     = "10.0.2.0/24"
  description = "Range IP da Subnet Privada do Projeto AVG"

}

#
# Variáveis Escopo Instâncias EC2 do Projeto
#

variable "nome_ami_instancia_ec2" {
  type        = string
  default     = "ami-04b70fa74e45c3917"
  description = "ID da imagem instância EC2 Amazon"

}

variable "nome_instancia_ec2_web" {
  type        = string
  default     = "srv-avg-web"
  description = "Nome da instância EC2 da Aplicação WEB"
}

variable "nome_instancia_ec2_db" {
  type        = string
  default     = "srv-avg-mongodb"
  description = "Nome da instância EC2 do Banco de Dados"
}


# variable "srv-avg-mongodb-ip" {
#   type = string
#   default = aws_ip
#   description = "IP privada do instância do Banco de Dados"

# }

variable "familia_instancia_ec2" {
  type        = string
  default     = "t2.micro"
  description = "Defini a família da instância EC2"

}

#
# Variáveis Escopo Internet Gateway
#

variable "nome_internet_gateway" {

  type        = string
  default     = "internet-gw-avg"
  description = "Nome do Internet Gateway do Projeto AVG"

}


#
# Variáveis Escopo IP Elástico do Internet Gateway 
#

variable "nome_ip_publico_internet_gw" {

  type        = string
  default     = "eip-nat-avg-nat-gw"
  description = "IP Elástico do Internet Gateway do Projeto AVG"

}

#
# Variáveis Escopo Nat Gateway da Subnet Privda 
#

variable "nome_nat_gateway" {

  type        = string
  default     = "nat-gw-avg-privada"
  description = "Nat Gateway da Subnet Privada do Projeto AVG"

}

#
# Variáveis Escopo Tabela de Rota da Subnet Pública 
#

variable "nome_rtb_subnet_publica" {

  type        = string
  default     = "rtb-avg-publica"
  description = "Nome da Tabela de Rota da Subnet Pública do Projeto AVG"

}

variable "cidr_block_rtb_publica" {

  type        = string
  default     = "0.0.0.0/0"
  description = "Cidr Block Tabela Rota da Subnet Pública do Projeto AVG"

}

#
# Variáveis Escopo Tabela de Rota da Subnet Privada 
#

variable "nome_rtb_subnet_privada" {

  type        = string
  default     = "rtb-avg-privada"
  description = "Nome da Tabela de Rota da Subnet Privada do Projeto AVG"

}

variable "cidr_block_rtb_privada" {

  type        = string
  default     = "0.0.0.0/0"
  description = "Cidr Block Tabela Rota da Subnet Privada do Projeto AVG"

}


#
# Variáveis Escopo Security Group da Subnet Pública 
#

variable "nome_security_group_subnet_publica" {

  type        = string
  default     = "security-group-avg-publica"
  description = "Nome do Security Group da Subnet Pública do Projeto AVG"

}

variable "regras_fw_sg_subnet_publica_ingresses" {
  default = [

    # Garantindo as configurações de Firewall Security Group Inbound

    {
      # HTTP
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # HTTPS
    {

      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # SSH
    {
      description      = "Acesso SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  ]

  description = "Nome do Security Group da Subnet Pública do Projeto AVG"

}

variable "regras_fw_sg_subnet_publica_egresses" {

  default = [

    # Garantindo as configurações de Firewall Security Group Oubound

    # HTTP
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # HTTPS
    {
      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # DNS
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # DNS
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # SSH
    {
      description      = "Acesso SSH para acesso interno subnet publica"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # MONGODB
    {
      description = "Acesso Banco de Dados MongoDB"

      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  ]

  description = "Nome do Security Group da Subnet Pública do Projeto AVG"

}


variable "nome_security_group_subnet_privada" {

  type        = string
  default     = "security-group-avg-privada"
  description = "Nome do Security Group da Subnet Privada do Projeto AVG"

}


variable "regras_fw_sg_subnet_privada_egresses" {

  default = [

    # Garantindo as configurações de Firewall Security Group Oubound

    # HTTP
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # HTTPS
    {
      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # DNS
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    # DNS
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }


  ]

}


#
# Variáveis Escopo ACL Subnet Pública 
#

variable "nome_acl_subnet_publica" {

  type        = string
  default     = "network-acl-avg-publica"
  description = "Nome da ACL da Subnet Pública do Projeto AVG"

}

variable "regras_acl_subnet_publica_ingresses" {

  default = [

    # Garantindo as configurações de Network ACL de Inbound

    # HTTP
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },

    # HTTPS
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

    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },

    # DNS
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },

    # DNS
    {
      protocol   = "udp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    }

  ]

}

variable "regras_acl_subnet_publica_egresses" {

  default = [

    # Garantindo as configurações de Network ACL Outbound

    # Port Efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },

    # HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },

    # HTTPS
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },

    # DNS
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },

    # DNS
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },

    # SSH
    {
      protocol   = "tcp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    }

  ]

}


variable "nome_acl_subnet_privada" {

  type        = string
  default     = "network-acl-avg-privada"
  description = "Nome da ACL da Subnet Privada do Projeto AVG"

}


variable "regras_acl_subnet_privada_ingresses" {

  default = [

    # Garantindo as configurações de Network ACL de Inbound

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

}

variable "regras_acl_subnet_privada_egresses" {

  default = [

    # Garantindo as configurações de Network ACL Outbound

    # Port Efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },

    # HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },

    # HTTPS
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },

    # DNS
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },

    # DNS
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    }


  ]

}