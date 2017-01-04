resource "aws_route53_zone" "test_domain" {
  name = "example.com"
}

resource "aws_route53_record" "top_record" {
  zone_id = "${aws_route53_zone.test_domain.zone_id}"
  name = "example.com"
  type = "A"

  alias {
    name = "${aws_elb.test_elb.dns_name}"
    zone_id = "${aws_elb.test_elb.zone_id}"
    evaluate_target_health = false
  }
}
