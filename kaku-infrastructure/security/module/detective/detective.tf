resource "aws_detective_graph" "default" {}

# resource "aws_detective_member" "default" {
#   account_id                 = "${var.account_id}"
#   email_address              = "${var.email_address}"
#   graph_arn                  = aws_detective_graph.default.id
#   message                    = "Message of the invitation"
#   disable_email_notification = true
# }