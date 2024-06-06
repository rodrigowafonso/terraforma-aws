# Garantindo que a key pair para acesso as instâncias

data "aws_key_pair" "key_devops_rodrigoafonso" {
  key_name           = "key_devops_rodrigoafonso"
  include_public_key = true

  filter {
    name   = "tag:Name"
    values = ["avg-web"]
  }
}

locals {

  ec2_ami = var.nome_ami_instancia_ec2

}

# Criando Instância da Aplicação Web

resource "aws_instance" "srv-avg-web" {
  ami           = local.ec2_ami
  instance_type = var.familia_instancia_ec2

  # Definindo em qual subnet a instância será provisionada
  subnet_id = aws_subnet.subnet-avg-publica.id

  # Garantindo que a instância terá um IP Público associado
  associate_public_ip_address = true

  # Definindo em qual ou quais Security Groups estará associado
  vpc_security_group_ids = [aws_security_group.security-group-avg-publica.id]

  # Definindo a key pair para acesso EC2
  key_name = data.aws_key_pair.key_devops_rodrigoafonso.key_name

  # Garantindo que a instalação do Docker seja feita na instância por meio do "User_Data"
  user_data = file("./instalacao-docker.sh")

  tags = {
    Name = var.nome_instancia_ec2_web
  }
}

# Criando Instância do Banco de Dados MongoDB

resource "aws_instance" "srv-avg-mongodb" {
  ami           = local.ec2_ami
  instance_type = var.familia_instancia_ec2

  # Definindo em qual subnet a instância será provisionada
  subnet_id = aws_subnet.subnet-avg-privada.id

  # Definindo em qual ou quais Security Groups estará associado
  vpc_security_group_ids = [aws_security_group.security-group-avg-privada.id]

  # Definindo a key pair para acesso EC2
  key_name = data.aws_key_pair.key_devops_rodrigoafonso.key_name

  # Garantindo que a instalação do Docker seja feita na instância por meio do "User_Data"
  user_data = file("./instalacao-docker.sh")

  tags = {
    Name = var.nome_instancia_ec2_db
  }
}

# Publicando o IP Público da Instância de Aplicação Web
output "srv-avg-web-ip" {

  value = aws_instance.srv-avg-web.public_ip

}

# Publicando o IP Privado da Instância do Banco de Dados
output "srv-avg-mongodb-ip" {

  value = aws_instance.srv-avg-mongodb.private_ip

}