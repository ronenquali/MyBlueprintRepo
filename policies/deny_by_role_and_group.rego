package torque.environment


result = {"decision": "Approved"} if {
	input.groups[0] = "g1"
}

result = {"decision": "Denied", "reason": input.space_name} if {
	false
}
