resource "aws_key_pair" "app_rsa"{
    key_name = "app_rsa"
    public_key = "${file("/ssh_keys/app_rsa.pub")}"

    
}