provider "aws" {
  region = "eu-west-1"
}


resource "aws_security_group" "instance" {
name = "terraform-Final_Projekt"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    //ipv6_cidr_blocks = ["::/0"]
  }

}



resource "aws_instance" "Final_Projekt" {
    ami           = "ami-0fd8802f94ed1c969"  // Ubuntu Server 20.04
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    user_data = file("Install_packages.sh")
    //user_data = file("Jenkins_run.sh")
    key_name= "aws_key"

    tags = {
        Name = "Ubuntu Server 20.04"
    }
}


output "public_ip_aws" {
    value = aws_instance.Final_Projekt.public_ip
    description = "The public IP address of the Final_Projekt AWS"
}