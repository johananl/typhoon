locals {
  # Pick a CoreOS Container Linux derivative
  # coreos-stable -> Container Linux AMI
  # flatcar-stable -> Flatcar Linux AMI
  ami_id = "${local.flavor == "flatcar" ? data.aws_ami.flatcar.image_id : data.aws_ami.coreos.image_id}"

  flavor  = "${element(split("-", var.os_image), 0)}"
  channel = "${element(split("-", var.os_image), 1)}"
  # Terraform ternary operators evaluate both sides and aws_ami's errors if an
  # AMI match isn't found. To allow flatcar-edge, the coreos AMI lookup should
  # default to stable (there is no edge) and be ignored
  coreos_channel = "${contains(list("stable", "beta", "alpha"), local.channel) ? local.channel : "stable" }"
}

data "aws_ami" "coreos" {
  most_recent = true
  owners      = ["595879546273"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["CoreOS-${local.coreos_channel}-*"]
  }
}

data "aws_ami" "flatcar" {
  most_recent = true
  owners      = ["075585003325"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["Flatcar-${local.channel}-*"]
  }
}
