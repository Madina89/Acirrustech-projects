resource "aws_instance" "docker" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["${aws_security_group.docker.name}"]


  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

  inline = [ 
    "yum install epel-release -y",
    "yum install docker -y"
  ]
    
  }

  tags = {
    Name = "${var.tag_name}"
  }
}