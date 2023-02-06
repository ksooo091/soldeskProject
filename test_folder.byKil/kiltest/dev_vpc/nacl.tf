resource "aws_default_network_acl" "iron_default" {
    default_network_acl_id = "${aws_vpc.iron.default_network_acl_id}"

    ingress {
        protocol = -1
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    egress {
        protocol = -1
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    subnet_ids = [
        "${aws_subnet.public_a.id}",
        "${aws_subnet.public_c.id}",
        "${aws_subnet.private_a.id}",
        "${aws_subnet.private_a.id}"
    ]

    tags = {
        Name = "iron_default"
    }
}