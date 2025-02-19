data "aws_caller_identity" "current" {}

resource "aws_iam_role" "terraform" {
  name               = "${var.environment}-TF"
  description        = "Role used for applying Terraform"
  assume_role_policy = data.aws_iam_policy_document.gitlab-tf.json
}

resource "aws_iam_role" "terraform-readonly" {
  name               = "${var.environment}-TF-ReadOnly"
  description        = "Role used for reading Terraform"
  assume_role_policy = data.aws_iam_policy_document.gitlab-tf-readonly.json
}

data "aws_iam_policy_document" "gitlab-tf" {
  version = "2012-10-17"

  statement {
    sid     = "AllowAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gitlab.arn]
    }

    condition {
      test     = "StringLike"
      variable = "${var.gitlab_domain}:sub"
      values   = var.gitlab_tf_admin_oidc_subs
    }

  }
}

data "aws_iam_policy_document" "gitlab-tf-readonly" {
  version = "2012-10-17"

  statement {
    sid     = "AllowAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gitlab.arn]
    }

    condition {
      test     = "StringLike"
      variable = "${var.gitlab_domain}:sub"
      values   = var.gitlab_tf_readonly_oidc_subs
    }

  }
}

data "aws_iam_policy_document" "terraform" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AdministratorAccess"
    ]
  }
}

data "aws_iam_policy_document" "terraform-readonly" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ReadOnlyAccess"
    ]
  }
}

resource "aws_iam_policy" "terraform" {
  name   = "terraform-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.terraform.json
}

resource "aws_iam_policy" "terraform-readonly" {
  name   = "terraform-policy-readonly"
  path   = "/"
  policy = data.aws_iam_policy_document.terraform-readonly.json
}

resource "aws_iam_role_policy_attachment" "terraform" {
  role       = aws_iam_role.terraform.name
  policy_arn = aws_iam_policy.terraform.arn
}

resource "aws_iam_role_policy_attachment" "terraform-readonly" {
  role       = aws_iam_role.terraform-readonly.name
  policy_arn = aws_iam_policy.terraform-readonly.arn
}

resource "aws_iam_openid_connect_provider" "gitlab" {
  url = "https://${var.gitlab_domain}"

  client_id_list = [
    "https://${var.gitlab_domain}",
  ]

  thumbprint_list = [var.gitlab_thumbprint]
}
