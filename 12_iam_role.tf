resource "aws_iam_role_policy" "iam-role-policy-1" {
  name = "role-policy-1"
  role = aws_iam_role.role-1.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameters",
          "secretsmanager:GetSecretValue",
          "kms:Decrypt"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "role-1" {
  name = "role-1"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}