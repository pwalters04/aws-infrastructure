#Create EC2 Instance 

resource "aws_vpc" "vpc-sandbox" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
        name = "sandbox-vpc"
    }
}

resource "aws_internet_gateway" "gateway-sandbox" {
  vpc_id = "${aws_vpc.vpc-sandbox.id}"
  tags = {
    Name = "sandbox-gateway"
  }
}

resource "aws_subnet" "public-subnet-sandbox" {
  count = "${length(var.subnets_cidr)}"  
  vpc_id     = "${aws_vpc.vpc-sandbox.id}"
  cidr_block = "${element(var.subnets_cidr, count.index)}"
  availability_zone ="${element(var.azs, count.index)}"

  tags = {
    Name = "Subnet-Sandbox${count.index+1}"
  }
}

# resource "aws_subnet" "private-subnet-sandox" {
#   vpc_id     = "${aws_vpc.vpc-sandbox.id}"
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "sandbox"
#   }
# }

resource "aws_route_table" "public-rt-sandbox" {
    vpc_id="${aws_vpc.vpc-sandbox.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id ="${aws_internet_gateway.gateway-sandbox.id}"
    }
    tags = {
        Name = "publicRouteTable-Sandbox"
    } 
}

resource "aws_route_table_association" "link-rt-sandbox" {
    count = "${length(var.subnets_cidr)}"
    subnet_id      = "${element(aws_subnet.public-subnet-sandbox.*.id,count.index)}"
    route_table_id = "${aws_route_table.public-rt-sandbox.id}"
}

resource "aws_security_group" "aws-sg-sandox" {
    name = "allow_http"
    description = "Allow Inbound Traffic"
    vpc_id = "${aws_vpc.vpc-sandbox.id}"

    ingress {
        from_port = 80
        to_port   = 80
        protocol = "tcp"
        cidr_blocks = "${var.public_cidr}"
    }
    egress{
        from_port = 0
        to_port   = 0
        protocol = -1
       cidr_blocks = "${var.public_cidr}"
    }
}
resource "aws_instance" "ec2-box" {
    count = "${length(var.subnets_cidr)}"
    ami = "${var.ami_server}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.aws-sg-sandox.id}"]
	subnet_id = "${element(aws_subnet.public-subnet-sandbox.*.id,count.index)}"
    user_data = "${file("mysql-install.sh")}"
    tags = {
        name = "ec2-box-${count.index+1}"
    }
}

