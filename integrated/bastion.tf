resource "aws_instance" "bastion_a" {
    ami = "ami-0b828c1c5ac3f13ee"
    availability_zone = "ap-northeast-1a"
    instance_type = "t3.small"
    key_name = "tokyokey"

    vpc_security_group_ids = [
        "${aws_security_group.bastion.id}",
    ]

    subnet_id = "${aws_subnet.public_a.id}"
    associate_public_ip_address = true

   
    tags = {
        Name = "bastion_a"
    }
    user_data = "${file("bastion.sh")}"

}

resource "aws_security_group" "bastion" {
    name = "bastion"
    description = "open ssh port for bastion"

    vpc_id = "${aws_vpc.iron.id}"
#ssh 만 열어두기 bastion
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 1194
        to_port = 1194
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
   
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

    tags = {
        Name = "bastion"
    }
}

resource "aws_eip" "bastion_a_eip" {
    instance = "${aws_instance.bastion_a.id}"
    vpc = true
}
