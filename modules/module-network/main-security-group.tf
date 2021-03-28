# Don't do anything with the default sg except add tags
resource "aws_default_security_group" "main" {
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_id}-default-security-group"
    Project = var.project_id
    user = var.user
    deployment_uuid = var.deployment_uuid
  }
}

resource "aws_security_group" "main" {
  vpc_id      = aws_vpc.main.id
  name        = "main"
  description = "main"

  tags = {
    Name = "${var.project_id}-main-security-group"
    Project = var.project_id
    user = var.user
    deployment_uuid = var.deployment_uuid
  }
}

resource "aws_security_group_rule" "internal_host_to_host_access" {
  security_group_id = aws_security_group.main.id
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  self            = true
}

resource "aws_security_group_rule" "return_traffic" {
  security_group_id = aws_security_group.main.id
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]
}
