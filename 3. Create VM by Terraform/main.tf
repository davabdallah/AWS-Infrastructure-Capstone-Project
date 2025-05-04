resource "aws_instance" "example" {
    ami           = var.image_id 
    instance_type = var.instance_type

    tags = {
      Name = "${var.project}-example"
    }
  }
