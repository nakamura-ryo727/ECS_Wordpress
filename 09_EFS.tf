resource "aws_efs_file_system" "efs-file-system-1" {
  creation_token = "${var.pj_name["name"]}-efs"

  tags = {
    Name = "${var.pj_name["name"]}-efs"
  }
}

resource "aws_efs_mount_target" "efs-mount-target-1" {
  file_system_id  = aws_efs_file_system.efs-file-system-1.id
  subnet_id       = aws_subnet.private-subnet-1.id
  security_groups = [aws_security_group.sg-efs.id]
}

resource "aws_efs_mount_target" "efs-mount-target-2" {
  file_system_id  = aws_efs_file_system.efs-file-system-1.id
  subnet_id       = aws_subnet.private-subnet-2.id
  security_groups = [aws_security_group.sg-efs.id]
}