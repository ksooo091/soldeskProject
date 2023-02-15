module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "18.29.0"

    cluster_name    =   "my-eks"
    cluster_version = "1.23"

    cluster_endpoint_private_access = true
    cluster_endpoint_public_access = true

    vpc_id  = "${aws_vpc.iron.id}"
    subnet_ids = [aws_subnet.private_a.id]

    enable_irsa = true

    eks_managed_node_group_defaults = {
        disk_size = 20
    }

    eks_managed_node_groups = {
        general = {
            desired_size = 2
            min_size = 2
            max_size = 3

            labels = {
                role = "general"
            }

            instance_type = ["t2.micro"]
            capacity_type = "ON_DEMAND"
        }

        spot = {
            desired_size = 1
            min_size = 1
            max_size = 10

            labels = {
                role = "spot"
            }

            taints = [{
                key = "market"
                value = "spot"
                effect = "NO_SCHEDULE"
            }]

            instance_type = ["t2.micro"]
            capacity_type = "SPOT"
        }
    }

    tags = {
        Enviroment  = "staging"
    }
}