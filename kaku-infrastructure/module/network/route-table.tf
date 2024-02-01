#publicサブネット用のルートテーブルを定義
resource "aws_route_table" "route-ingress" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "${var.tag_name}-route-ingress"
    group = "${var.tag_group}"
  }
}

resource "aws_route_table_association" "public_subnet_ingress_1_route" {
  subnet_id      = aws_subnet.public_subnet_ingress_1.id
  route_table_id = aws_route_table.route-ingress.id
}

resource "aws_route_table_association" "public_subnet_ingress_2_route" {
  subnet_id      = aws_subnet.public_subnet_ingress_2.id
  route_table_id = aws_route_table.route-ingress.id
}


#node.js用のprivateサブネット用のルートテーブルを定義
resource "aws_route_table" "route_nodejs" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.tag_name}-route-nodejs"
    group = "${var.tag_group}"
  }
}

resource "aws_route_table_association" "private_subnet_nodejs_1_route" {
  subnet_id      = aws_subnet.private_subnet_nodejs_1.id
  route_table_id = aws_route_table.route_nodejs.id
}

#puma用のprivateサブネット用のルートテーブルを定義
resource "aws_route_table" "route_puma" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.tag_name}-route-puma"
    group = "${var.tag_group}"
  }
}

resource "aws_route_table_association" "private_subnet_puma_1_route" {
  subnet_id      = aws_subnet.private_subnet_puma_1.id
  route_table_id = aws_route_table.route_puma.id
}

#mysql用のprivateサブネット用のルートテーブルを定義
resource "aws_route_table" "route-mysql" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.tag_name}-route-mysql"
    group = "${var.tag_group}"
  }
}

resource "aws_route_table_association" "private_subnet_mysql_1_route" {
  subnet_id      = aws_subnet.private_subnet_mysql_1.id
  route_table_id = aws_route_table.route-mysql.id
}

resource "aws_route_table_association" "private_subnet_mysql_2_route" {
  subnet_id      = aws_subnet.private_subnet_mysql_2.id
  route_table_id = aws_route_table.route-mysql.id
}