output "tf_admin_role_arn" {
  value = aws_iam_role.terraform.arn
}

output "tf_readonly_role_arn" {
  value = aws_iam_role.terraform-readonly.arn
}
