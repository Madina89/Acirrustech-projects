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
      "sudo yum install -y yum-utils device-mapper-persistent-data lvm2",
      "sudo yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum-config-manager --enable docker-ce-nightly",
      "sudo yum-config-manager --enable docker-ce-test",
      "sudo yum-config-manager --disable docker-ce-nightly",
      "sudo yum install docker-ce docker-ce-cli containerd.io"
    ]
  }
  tags = {
    Name = "Docker"
  }
}
