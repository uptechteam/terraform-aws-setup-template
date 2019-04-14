output "iam_ak" {
  value = "${module.service_iam.iam_access_key_id}"
}

output "iam_sk" {
  value = "${module.service_iam.iam_access_key_secret}"
}

output "dev_ip" {
  value = "${module.dev_instance.instance_ip}"
}

output "staging_ip" {
  value = "${module.staging_instance.instance_ip}"
}