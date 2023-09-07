packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  region                      = "us-east-2"
  ami_name                    = "ami-build-with-packer-{{timestamp}}"
  instance_type               = "t2.micro"
  source_ami                  = "ami-0430580de6244e02e"
  ssh_username                = "ubuntu"
  associate_public_ip_address = true
  subnet_id                   = "subnet-040a331d4c3bf167e"
  security_group_id           = "sg-0073829f31cd7a8a4"
  ssh_private_key_file = "~/.ssh/id_rsa.pub.pem" 
  ami_regions = [
    "us-east-2"
  ]
}




build {
  name = "my-first-build"
  sources = ["source.amazon-ebs.ubuntu"]
  
  provisioner "ansible" {
    playbook_file = "ubuntu-playbook.yml"
  }
}

