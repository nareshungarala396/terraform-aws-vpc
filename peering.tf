resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1 : 0
  vpc_id        = aws_vpc.main.id
  peer_vpc_id   = data.aws_vpc.default.id  # acceptor

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  auto_accept   = true # Set to true if both VPCs are in the same account and region
  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-default"
    }
  )
}

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id         = aws_route_table.public.id # ID of the route table in the local VPC
  destination_cidr_block = data.aws_vpc.default.cidr_block            # CIDR block of the peer VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id         = data.aws_route_table.main.id # ID of the route table in the peer VPC
  destination_cidr_block = var.vpc_cidr             # CIDR block of the local VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}