package torque.environment

result := {"decision": "Denied", "reason": input.groups[0]} if {
	input.groups[0] == "g1x"
}

else := {"decision": "Approved", "reason": "Sure whatever…"}


