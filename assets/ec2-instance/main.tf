resource "aws_instance" "testEC2" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = "subnet-0124294163b6e76e0"
    tags = {
        Name = "testEC2"
    }
}
