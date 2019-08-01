resource "aws_instance" "docker" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_docker"]


  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo yum install epel-release && yum install docker"
      "sudo systemctl start docker"
    ]
  }
  tags = {
    Name = "Docker"
  }
}
