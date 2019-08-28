resource "aws_elb" "elb-sandbox" {
  name               = "LB-Sanbox"
  subnets = "${aws_subnet.public-subnet-sandbox.*.id}"
  security_groups = ["${aws_security_group.aws-sg-sandox.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = "${aws_instance.ec2-box.*.id}"
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    name = "terraform-elb"
  }
}

output "elb-dns-name" {
  value = "${aws_elb.elb-sandbox.dns_name}"
}