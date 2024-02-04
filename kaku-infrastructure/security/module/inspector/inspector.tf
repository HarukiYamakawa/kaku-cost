resource "aws_inspector2_enabler" "ecr" {
  account_ids    = ["${var.account_id}"]
  resource_types = ["ECR"]
}