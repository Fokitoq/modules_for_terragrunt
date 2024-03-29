



# Launch configuration description
resource "aws_launch_configuration" "ASG_launch_config" {
  name                        = "Docker_ASG_Launch_config_${var.env}"
  image_id                    = var.image_id  #  AMI ID
  instance_type               = var.instance_type               # instance type
  key_name                    = var.key_name    # key name
  security_groups             = [aws_security_group.instance_sg.id]
  user_data                   = templatefile("./user-data.sh", {})  #  User data file

}






