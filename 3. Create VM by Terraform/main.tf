resource "aws_instance" "example" {
    ami           = var.ami "ami-0f88e80871fd81e91" 
    instance_type = var.instance_type "t2.micro"

    tags = {
      Name = "example-instance"
    }
  }
