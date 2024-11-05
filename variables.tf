variable "environment" {
  type        = string
  description = "Environment name"
}

variable "gitlab_tf_admin_oidc_subs" {
  type        = list(string)
  description = "Allow gitlab to assume tf admin roles"
}

variable "gitlab_tf_readonly_oidc_subs" {
  type        = list(string)
  description = "Allow gitlab to assume tf readonly roles"
}
