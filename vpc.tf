# vpc
resource "aws_vpc" "myvpc" {

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }

}
# public subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"

}
# private subnet
resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"

}

# internet gate way (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

}

# route table
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}
# route table association
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
}