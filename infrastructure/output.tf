output "iam_ak" {
  value = "${module.service_iam.iam_access_key_id}"
}

output "iam_sk" {
  value = "${module.service_iam.iam_access_key_secret}"
}