package torque.environment

import future.keywords.if

result = { "decision": "Denied", "reason": "No running in space!" } if {
    input.space_name == "space1"
} else = { "decision": "Approved", "reason": "whatever" } if {
    true
}
