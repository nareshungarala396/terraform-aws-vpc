data "aws_availability_zones" "available" {
  # No arguments needed, it will fetch all AZs in the current region
  # You can optionally filter by state or other attributes if desired
  state = "available"

}

data "aws_vpc" "default" {
  default = true
}

data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}