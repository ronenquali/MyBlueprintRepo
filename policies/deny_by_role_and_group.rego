package torque.environment

import future.keywords.if

result = { "decision": "Approved", "reason": "I'm nice that way" } if {
    input
}

result = { "decision": "Denied", "reason": "Becasue why not..." } if {
    input.space_name == "space1"
}
