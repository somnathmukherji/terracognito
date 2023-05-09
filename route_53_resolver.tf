resource "aws_route53_resolver_rule_association" "rslvr_autodefined_assoc_vpc_04162339f4a5e040c_internet_resolver" {
  name             = "System Rule Association"
  resolver_rule_id = "rslvr-autodefined-rr-internet-resolver"
  vpc_id           = aws_vpc.my_vpc.id
}

resource "aws_route53_resolver_rule_association" "rslvr_autodefined_assoc_vpc_0b465b629e3cf3bed_internet_resolver" {
  name             = "System Rule Association"
  resolver_rule_id = "rslvr-autodefined-rr-internet-resolver"
  vpc_id           = aws_vpc.vpc_0b465b629e3cf3bed.id
}

