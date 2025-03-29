data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "web" {
  ami           =  data.aws_ami.ubuntu.id                       
  instance_type = "t3.medium"
  subnet_id = "${aws_subnet.main.id}"
  associate_public_ip_address = true
user_data = <<-EOF
#cloud-config
runcmd:
  - apt-get update
  - apt-get install -y apache2 net-tools
  - snap install aws-cli --classic
  - aws s3 cp s3://${aws_s3_bucket.this.id}/index.html /var/www/html/
  - systemctl restart apache2
EOF
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  tags = {
    Name = "myec2-tf"
  }
}