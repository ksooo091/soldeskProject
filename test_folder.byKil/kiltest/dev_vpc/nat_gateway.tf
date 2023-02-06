resource "aws_nat_gateway" "nat_a" {
    allocation_id = "${aws_eip.iron_eip_a.id}"
    subnet_id = "${aws_subnet.public_a.id}"
}

resource "aws_nat_gateway" "nat_c" {
    allocation_id = "${aws_eip.iron_eip_c.id}"
    subnet_id = "${aws_subnet.public_c.id}"
}