package torque.environment

result := {"decision": "Denied", "reason": "No means no!"} if {
	"Simpletons" in input.groups
}

else := {"decision": "Approved", "reason": "Sure whatever…"}
