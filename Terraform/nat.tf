
# Elastic IPs para cada NAT Gateway (uno por zona)
resource "aws_eip" "nat_eip" {
  count = length(aws_subnet.public)
  tags  = { Name = "JuanWordpress-nat-eip-${count.index + 1}" }
}

# NAT Gateways (uno por cada subnet pública)
resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.public)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.igw]
  tags          = { Name = "JuanWordpress-nat-${count.index + 1}" }
}

# Route Tables privadas (una por cada private subnet)
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = { Name = "JuanWordpress-private-rt-${count.index + 1}" }
}

# Asociar cada private subnet a su route table correspondiente
resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
