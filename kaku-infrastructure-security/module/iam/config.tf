resource "aws_iam_role" "config-role" {
  name = "${var.name_prefix}-config-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "config.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

#Configのマネージドポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "config-role-policy" {
  role       = aws_iam_role.config-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}