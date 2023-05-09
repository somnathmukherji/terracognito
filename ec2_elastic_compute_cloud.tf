resource "aws_instance" "nat_instance" {
  tags = {
    Name = "NAT_INSTANCE"
  }

  tags_all = {
    Name = "NAT_INSTANCE"
  }

  ami               = "ami-081a91961c85e3640"
  availability_zone = "ap-south-1a"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  #cpu_options       = 1
#  cpu_threads_per_core = 1
  credit_specification {
    cpu_credits = "standard"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.prodkey.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "10.0.1.124"
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "standard"
  }

  subnet_id              = aws_subnet.public_subnet_1.id
  tenancy                = aws_vpc.vpc_0b465b629e3cf3bed.instance_tenancy
  vpc_security_group_ids = [aws_security_group.nat_sg.id]
}

resource "aws_instance" "terracognito" {
  tags = {
    Name = "TERRACOGNITO"
  }

  tags_all = {
    Name = "TERRACOGNITO"
  }

  ami                         = "ami-02eb7a4783e7e9317"
  associate_public_ip_address = true
  availability_zone           = "ap-south-1a"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

#  cpu_core_count       = 1
 # cpu_threads_per_core = 1
  credit_specification {
    cpu_credits = "standard"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.prodkey.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "10.0.1.96"
  root_block_device {
    delete_on_termination = true
    iops                  = 100
    volume_size           = 8
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.public_subnet_1.id
  tenancy                = aws_vpc.vpc_0b465b629e3cf3bed.instance_tenancy
  vpc_security_group_ids = [aws_security_group.nat_sg.id]
}

resource "aws_instance" "webserver1" {
  tags = {
    Name = "WEBSERVER1"
  }

  tags_all = {
    Name = "WEBSERVER1"
  }

  ami               = "ami-02eb7a4783e7e9317"
  availability_zone = "ap-south-1a"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

 # cpu_core_count       = 1
 # cpu_threads_per_core = 1
  credit_specification {
    cpu_credits = "standard"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.prodkey.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "10.0.0.115"
  root_block_device {
    delete_on_termination = true
    iops                  = 100
    volume_size           = 8
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.private_subnet_1.id
  tenancy                = aws_vpc.vpc_0b465b629e3cf3bed.instance_tenancy
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_instance" "webserver2" {
  tags = {
    Name = "WEBSERVER21"
  }

  tags_all = {
    Name = "WEBSERVER2"
  }

  ami               = "ami-01b81d104d67357da"
  #state       = "stopped"
  availability_zone = "ap-south-1a"
  capacity_reservation_specification {
   capacity_reservation_preference = "open"
  }

  #cpu_core_count       = 1
  #cpu_threads_per_core = 1
  credit_specification {
    cpu_credits = "standard"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.prodkey.key_name
  launch_template {
  #  id   = aws_launch_template.lt_0eaadbe9214c86ad1.id
    name = "WEBSRVER_LB"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "10.0.0.107"
  root_block_device {
    delete_on_termination = true
    iops                  = 100
    volume_size           = 8
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.private_subnet_1.id
  tenancy                = aws_vpc.vpc_0b465b629e3cf3bed.instance_tenancy
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_ec2_instance_state" "webserver" {
  instance_id = aws_instance.webserver2.id
  state       = "stopped"
}

resource "aws_key_pair" "aws_key" {
  key_name   = "aws_key"
  public_key = ""
}

resource "aws_key_pair" "prodkey" {
  key_name   = "prodkey"
  public_key = ""
}

resource "aws_launch_template" "lt_0eaadbe9214c86ad1" {
  default_version = 1
  description     = "PRODSERVERS"
  image_id        = "ami-01b81d104d67357da"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.prodkey.key_name
  name            = "WEBSRVER_LB"
  network_interfaces {
    security_groups = [aws_security_group.web_sg.id]
    subnet_id       = aws_subnet.private_subnet_1.id
  }

}

