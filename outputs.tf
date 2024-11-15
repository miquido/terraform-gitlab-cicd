output "tf_admin_role_arn" {
  value = aws_iam_role.terraform.arn
}

output "tf_readonly_role_arn" {
  value = aws_iam_role.terraform-readonly.arn
}

output "tf_admin_role_name" {
  value = aws_iam_role.terraform.name
}

output "tf_readonly_role_name" {
  value = aws_iam_role.terraform-readonly.name
}
