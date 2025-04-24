package torque.environment

result := {"decision": "Denied", "reason": input.groups[0]} if {
	input.groups[0] == "g1"
}

else := {"decision": "Approved", "reason": "Sure whatever…"}

