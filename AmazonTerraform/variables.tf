variable "vpc_cidr" {
	default = "10.10.0.0/16"
}

variable "subnets_cidr" {
	type = "list"
	default = ["10.10.1.0/24", "10.10.2.0/24"]
}
variable "public_cidr" {
    type = "list"
    default =["0.0.0.0/0"]
}

variable "azs" {
	type = "list"
	default = ["us-east-1a", "us-east-1b"]
}
variable "ami_server" {
  default ="ami-035b3c7efe6d061d5"
}

variable "instance_type" {
  default = "t2.micro"
}
