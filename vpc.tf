# Create a VPC avg Hands-on DevopsPró
resource "aws_vpc" "vpc-avg-devopspro" {
  cidr_block = var.cidr_block_vpc_avg

  tags = {
    Name = var.nome_vpc_projeto_avg
  }

}

# Criando Subnet avg pública
resource "aws_subnet" "subnet-avg-publica" {
  vpc_id     = aws_vpc.vpc-avg-devopspro.id
  cidr_block = var.cidr_block_subnet_publica

  tags = {
    Name = var.nome_subnet_publica
  }
}

# Criando subnet avg privada
resource "aws_subnet" "subnet-avg-privada" {
  vpc_id     = aws_vpc.vpc-avg-devopspro.id
  cidr_block = var.cidr_block_subnet_privada

  tags = {
    Name = var.nome_subnet_privada
  }
}

# Criando o Internet Gateway 
resource "aws_internet_gateway" "internet-gw-avg" {

  tags = {
    Name = var.nome_internet_gateway
  }
}

# Vinculando o Internet Gateway na VPC vpc-avg-devopspro
resource "aws_internet_gateway_attachment" "internet-gw-avg-attach" {
  internet_gateway_id = aws_internet_gateway.internet-gw-avg.id
  vpc_id              = aws_vpc.vpc-avg-devopspro.id

}

# Criando um IP Elástico e vinculando ao Internet Gateway
resource "aws_eip" "eip-nat-avg-nat-gw" {
  depends_on = [aws_internet_gateway.internet-gw-avg]

  tags = {
    Name = var.nome_ip_publico_internet_gw
  }

}

# Criando o Nat Gateway para Subnet Privada
resource "aws_nat_gateway" "nat-gw-avg-privada" {
  allocation_id = aws_eip.eip-nat-avg-nat-gw.id
  subnet_id     = aws_subnet.subnet-avg-publica.id

  tags = {
    Name = var.nome_nat_gateway
  }

  # Garantindo que o Nat Gateway ficará vinculado ao Internet Gateway da VPC 
  depends_on = [aws_internet_gateway.internet-gw-avg]
}

# Criando as tabelas de rotas de subnet pública
resource "aws_route_table" "rtb-avg-publica" {
  vpc_id = aws_vpc.vpc-avg-devopspro.id

  route {
    cidr_block = var.cidr_block_rtb_publica
    gateway_id = aws_internet_gateway.internet-gw-avg.id
  }

  tags = {
    Name = var.nome_rtb_subnet_publica
  }
}

# Garantindo que a tabela de rota pública esta vinculada a subnet pública
resource "aws_route_table_association" "rtb-avg-publica-association" {
  subnet_id      = aws_subnet.subnet-avg-publica.id
  route_table_id = aws_route_table.rtb-avg-publica.id
}

# Criando as tabelas de rotas de subnet privada
resource "aws_route_table" "rtb-avg-privada" {
  vpc_id = aws_vpc.vpc-avg-devopspro.id

  route {
    cidr_block     = var.cidr_block_rtb_privada
    nat_gateway_id = aws_nat_gateway.nat-gw-avg-privada.id
  }

  tags = {
    Name = var.nome_rtb_subnet_privada
  }
}

# Garantindo que a tabela de rota privada esta vinculada a subnet pública
resource "aws_route_table_association" "rtb-avg-privada-association" {
  subnet_id      = aws_subnet.subnet-avg-privada.id
  route_table_id = aws_route_table.rtb-avg-privada.id
}

