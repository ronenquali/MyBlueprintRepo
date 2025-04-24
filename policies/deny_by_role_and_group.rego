package torque.environment

result := {"decision": "Denied", "reason": "No means no!"} if {
	"g2" in input.groups
}

else := {"decision": "Approved", "reason": "Sure whatever…"}
