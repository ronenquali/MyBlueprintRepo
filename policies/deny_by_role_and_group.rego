package torque.environment

import future.keywords.if

result = {"decision": "Approved"} if {
	user_email == "noreply@quali.com"
}

result = {"decision": "Approved"} if {
	input.groups[0] == "g1"
}

result = {"decision": "Denied", "reason": input.space_name} if {
	input.groups[0] != "g1"
}
