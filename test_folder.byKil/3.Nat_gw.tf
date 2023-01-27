#Nat gateway는 요금부과 됨 !!!!!!!!!!!!!!!!!!!!!!!!!!!
# 테스트임 !!!!!!!!!!!!!!!!!!!!!!!
/* 
resource "aws_ec2" "soldesk-nip" {
    vpc = true
    tags = {
        Name = "soldesk-nip"
    }
}

resource "aws_nat_gateway" "soldesk-ngw" {
    allocation_id = aws_ec2.soldesk-nip.id
    subnet_id = aws_subnet.soldesk-sub-public-a.id
    tags = {
        Name = "soldesk-ngw"
    }
}
*/