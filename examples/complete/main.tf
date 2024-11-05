module "cicd-tf-dev" {
  source                       = "../../"
  environment                  = "dev"
  gitlab_tf_admin_oidc_subs    = ["project_path:test/repo:ref_type:branch:ref:dev"]
  gitlab_tf_readonly_oidc_subs = ["project_path:test/repo:ref_type:branch:ref:*"]
}