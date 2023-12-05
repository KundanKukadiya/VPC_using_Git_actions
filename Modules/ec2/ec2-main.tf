resource "aws_instance" "my-ec2" {
  count                       = length(var.ec2-name)
  ami                         = "ami-06d4b7182ac3480fa"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.subnets[count.index]
  availability_zone = data.aws_availability_zones.zone.names[count.index]
  user_data = <<EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello Terraform using Github from $(hostname -f)</h1>" > /var/www/html/index.html
  
  EOF


  tags = {
    Name = var.ec2-name[count.index]
  }
}