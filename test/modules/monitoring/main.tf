
data "aws_key_pair" "pro-key" {
  filter {
    name = "tag:purpose"
    values = ["project"]
  }
}

resource "aws_instance" "monitoring-instance" {
  ami           = var.ami-mon
  instance_type = var.instance-mon
  key_name = data.aws_key_pair.pro-key.key_name
  subnet_id = var.subnet-mon
  vpc_security_group_ids = [var.sg-mon]
  private_ip = var.privateip-mon
  user_data = filebase64("${path.module}/userdata.sh")
  tags = {
		Name = "monitoring-test"
	}
}

## infux,elasticsearch,grafan,kibana

