package torque.environment

import future.keywords.if

result = {"decision": "Approved"} if {
	input.groups[0] = "g1jhgdfvjsdvbfj"
}

result = {"decision": "Denied", "reason": input.space_name} if {
	input.groups[0] != "g1"
}
