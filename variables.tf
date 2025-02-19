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

variable "gitlab_domain" {
  type        = string
  default     = "gitlab.com"
  description = "Where gitlab is hosted fe. gitlab.example.com"
}

variable "gitlab_thumbprint" {
  type        = string
  default     = "fb07e4e621fa075c961b661ae299ade7681df5d5"
  description = "Thumbprint of given gitlab instance"
}