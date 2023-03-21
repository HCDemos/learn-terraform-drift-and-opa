package terraform.policies.compute_vm_size

import future.keywords.in
import input.plan as tfplan

actions := [
	["no-op"],
	["create"],
	["update"],
]

types := [
	"t2.nano",
	"t2.micro"
]

resources := [resource_changes |
	resource_changes := tfplan.resource_changes[_]
	resource_changes.type == "aws_instance"
	resource_changes.mode == "managed"
	resource_changes.change.actions in actions
]

violations := [resource |
	resource := resources[_]
	not resource.change.after.size in types
]

violators[address] {
	address := violations[_].address
}

# METADATA
# title: AWS-COMPUTE-001
# description: Ensure only allowed VM size values are defined
# custom:
#  severity: low
#  enforcement_level: mandatory
# authors:
# - name: Dan Barr
# organizations:
# - HashiCorp
rule[result] {
	count(violations) != 0
	result := {
		"policy": rego.metadata.rule().title,
		"description": rego.metadata.rule().description,
		"severity": rego.metadata.rule().custom.severity,
		"enforcement_level": rego.metadata.rule().custom.enforcement_level,
		"resources": {
			"count": count(violations),
			"addresses": violators,
		},
	}
}
