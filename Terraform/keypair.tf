# Generar una nueva clave privada RSA localmente
resource "tls_private_key" "wordpress_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Crear el Key Pair en AWS usando la clave pública generada
resource "aws_key_pair" "wordpress_keypair" {
  key_name   = "Juan-key"
  public_key = tls_private_key.wordpress_key.public_key_openssh
}

# Guardar la clave privada localmente como archivo .pem
resource "local_file" "private_key" {
  content              = tls_private_key.wordpress_key.private_key_pem
  filename             = "${path.module}/Juan-key.pem"
  file_permission      = "0400"
}