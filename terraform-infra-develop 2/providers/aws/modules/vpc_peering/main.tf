# Versions # Providers
terraform {

  required_version = ">= 1.1.5"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.4"
      configuration_aliases = [aws.origin, aws.peer]
    }
  }
}

# Get account and region info
data "aws_caller_identity" "origin" {
  provider = aws.origin
}
data "aws_region" "origin" {
  provider = aws.origin
}
data "aws_caller_identity" "peer" {
  provider = aws.peer
}
data "aws_region" "peer" {
  provider = aws.peer
}

# Get vpc info
data "aws_vpc" "origin_vpc" {
  provider = aws.origin
  id       = var.origin_vpc_id
}
data "aws_vpc" "peer_vpc" {
  provider = aws.peer
  id       = var.peer_vpc_id
}

# Get all route tables from vpcs
data "aws_route_tables" "origin_vpc_rts" {
  provider = aws.origin
  vpc_id   = var.origin_vpc_id
}
data "aws_route_tables" "peer_vpc_rts" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id
}

# get subnets info
data "aws_subnet" "origin" {
  count    = length(var.origin_subnets_ids)
  provider = aws.origin
  id       = var.origin_subnets_ids[count.index]
}
data "aws_subnet" "peer" {
  count    = length(var.peer_subnets_ids)
  provider = aws.peer
  id       = var.peer_subnets_ids[count.index]
}

# Get info for only those route tables associated with the given subnets
data "aws_route_table" "origin_subnet_rts" {
  count     = length(var.origin_subnets_ids)
  provider  = aws.origin
  subnet_id = var.origin_subnets_ids[count.index]
}

data "aws_route_table" "peer_subnet_rts" {
  count     = length(var.peer_subnets_ids)
  provider  = aws.peer
  subnet_id = var.peer_subnets_ids[count.index]
}

locals {
  origin_region = data.aws_region.origin.name
  peer_region = data.aws_region.peer.name

  # Rout table should either be the one for the vpc, or the ones associated to the subnets if subnets are given
  origin_rts_ids_new = data.aws_route_tables.origin_vpc_rts.ids
  peer_rts_ids_new = data.aws_route_tables.peer_vpc_rts.ids

  origin_rts_ids = length(var.origin_subnets_ids) == 0 ? local.origin_rts_ids_new : data.aws_route_table.origin_subnet_rts[*].route_table_id
  peer_rts_ids = length(var.peer_subnets_ids) == 0 ? local.peer_rts_ids_new : data.aws_route_table.peer_subnet_rts[*].route_table_id

  # `origin_dest_cidrs` represent CIDR of peer VPC, therefore a destination CIDR for origin_vpc
  # `peer_dest_cidrs` represent CIDR of origin VPC, therefore a destination CIDR for peer_vpc
  # Destination cidrs for origin are in peer and vice versa
  origin_dest_cidrs = length(var.peer_subnets_ids) == 0 ? toset([data.aws_vpc.peer_vpc.cidr_block]) : toset(data.aws_subnet.peer[*].cidr_block)
  peer_dest_cidrs = length(var.origin_subnets_ids) == 0 ? toset([data.aws_vpc.origin_vpc.cidr_block]) : toset(data.aws_subnet.origin[*].cidr_block)

  # Allow specifying route tables explicitly
  origin_rts_ids_hack = length(var.origin_rts_ids) == 0 ? local.origin_rts_ids : var.origin_rts_ids
  peer_rts_ids_hack = length(var.peer_rts_ids) == 0 ? local.peer_rts_ids : var.peer_rts_ids

  # In each route table there should be 1 route for each subnet, so combining the two sets
  origin_routes = [
    for pair in setproduct(local.origin_rts_ids_hack, local.origin_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]

  # In each route table there should be 1 route for each subnet, so combining the two sets
  peer_routes = [
    for pair in setproduct(local.peer_rts_ids_hack, local.peer_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]
}

# VPC peering connection
resource "aws_vpc_peering_connection" "origin" {
  provider      = aws.origin
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.origin_vpc_id
  peer_region   = data.aws_region.peer.name
  tags          = merge(var.tags, tomap({ "Side" = "Requester" }))
  # hardcoded
  timeouts {
    create = "15m"
    delete = "15m"
  }
}

# VPC peering accepter configuration
resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.origin.id
  auto_accept               = var.auto_accept_peering
  tags                      = merge(var.tags, tomap({ "Side" = "Accepter" }))
}

# origin VPC Routes #  Route from origin route table to PEER cidr
resource "aws_route" "origin_routes" {
  provider = aws.origin
  # Only create routes for origin route table if input dictates it, and in that case, for all combinations
  count                     = var.from_origin ? length(local.origin_routes) : 0
  route_table_id            = local.origin_routes[count.index].rts_id
  destination_cidr_block    = local.origin_routes[count.index].dest_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.origin.id
}

# Peer VPC Routes #  Route from PEER route table to origin cidr
resource "aws_route" "peer_routes" {
  provider = aws.peer
  # Only create routes for peer route table if input dictates it, and in that case, for all combinations
  count                     = var.from_peer ? length(local.peer_routes) : 0
  route_table_id            = local.peer_routes[count.index].rts_id
  destination_cidr_block    = local.peer_routes[count.index].dest_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.origin.id
}
