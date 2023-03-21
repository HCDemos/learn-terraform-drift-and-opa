policy "compute-001-aws-vm-size" {
  query = "data.terraform.policies.aws.compute_001.rule"
  enforcement_level = "mandatory"
  description = "Enforce preferred VM size"
}

policy "friday_deploys" {
  query = "data.terraform.policies.friday_deploys.deny"
  enforcement_level = "mandatory"
  description = "No Friday Deploys!"
}

policy "public_ingress" {
  query = "data.terraform.policies.public_ingress.deny"
  enforcement_level = "mandatory"
  description = "Limit public ingress"
}




