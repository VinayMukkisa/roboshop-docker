resource "aws_instance" "this" {
    ami = local.ami_id
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-08ab4d82756ecaa18"]
    root_block_device {
        volume_size = 50
        volume_type = "gp3" # or "gp2", depending on your preference
    }
    user_data = file("bootstrap.sh")
    tags = merge (
        local.common_tags,
        {
            Name = "${var.project_name}-${var.environment}-docker"
        }
    )
}
