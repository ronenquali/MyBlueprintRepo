package torque.environment

result := {"decision": "Denied", "reason": "No means no!"} if {
	input.groups[0] == "g1x"
}

else := {"decision": "Approved", "reason": "Sure whatever…"}
