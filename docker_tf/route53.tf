resource "aws_route53_record" "docker" {
  zone_id = "${var.zone_id}"
  names    = [
    "docker.${var.domain}",
    "docker.${var.domain}",
    "docker.${var.domain}",
  ]   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.docker.public_ip}"]
  
}