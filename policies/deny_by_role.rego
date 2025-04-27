package torque.environment

import future.keywords.if

result = {"decision": "Approved"} if {
	input.roles.space_roles[0] == "Space Adminxxxxxxxxxxx"
}

result = {"decision": "Denied", "reason": input.space_name} if {
	input.roles.space_roles[0] != "Space Adminxxxxxxxxxxx"
}
