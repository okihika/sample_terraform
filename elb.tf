resource "aws_elb" "test_elb" {
  name = "test-elb"
  subnets = [
    "${aws_subnet.vpc-1-subnet-1a.id}",
    "${aws_subnet.vpc-1-subnet-1c.id}",
  ]
  security_groups = [
    "${aws_security_group.web.id}",
  ]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "arn:aws:acm:ap-northeast-1:xxxxxxxxxxxxxxxxxxxxxxxxxx"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/check.html"
    interval = 30
  }
  instances = ["${aws_instance.apache-1a.id}","${aws_instance.apache-1c.id}"]
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags {
    Name = "test-elb"
  }
}
