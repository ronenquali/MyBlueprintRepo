package torque.environment
import future.keywords.if

#helper functions
get_unit_number(max_duration_ns, index) = date_number {
	diff_data := time.diff(max_duration_ns, 0)
	date_number := diff_data[index]
}

days(max_duration_ns) = days_str {
	years_number := get_unit_number(max_duration_ns, 0)
    months_number := get_unit_number(max_duration_ns, 1)
	days_number := get_unit_number(max_duration_ns, 2)
    days := years_number * 365 + months_number * 30 + days_number
    days != 0
    days_str := concat(" ", [sprintf("%v", [days]), "days"])
}

hours(max_duration_ns) = hours_str {
	hours_number := get_unit_number(max_duration_ns, 3)
    hours_number != 0
    hours_str := concat(" ", [sprintf("%v", [hours_number]), "hours"])
}

minutes(max_duration_ns) = minutes_str {
	minutes_number := get_unit_number(max_duration_ns, 4)
    minutes_number != 0
    minutes_str := concat(" ", [sprintf("%v", [minutes_number]), "minutes"])
}

get_timespan_string(max_duration_ns) = timespan {
    days_str = days(max_duration_ns)
	hours_str = hours(max_duration_ns)
    minutes_str = minutes(max_duration_ns)
	timespan := concat(" ", [days_str, hours_str, minutes_str])
}

get_timespan_string(max_duration_ns) = timespan {
    days_str = days(max_duration_ns)
	hours_str = hours(max_duration_ns)
    not minutes(max_duration_ns)
	timespan := concat(" ", [days_str, hours_str])
}

get_timespan_string(max_duration_ns) = timespan {
    days_str = days(max_duration_ns)
	minutes_str = minutes(max_duration_ns)
	not hours(max_duration_ns)
	timespan := concat(" ", [days_str, minutes_str])
}

get_timespan_string(max_duration_ns) = timespan {
    hours_str = hours(max_duration_ns)
	minutes_str = minutes(max_duration_ns)
	not days(max_duration_ns)
	timespan := concat(" ", [hours_str, minutes_str])
}

get_timespan_string(max_duration_ns) = timespan {
	days_str = days(max_duration_ns)
    not hours(max_duration_ns)
    not minutes(max_duration_ns)
	timespan := concat(" ", [days_str])
}

get_timespan_string(max_duration_ns) = timespan {
	hours_str = hours(max_duration_ns)
    not days(max_duration_ns)
    not minutes(max_duration_ns)
	timespan := concat(" ", [hours_str])
}

get_timespan_string(max_duration_ns) = timespan {
	minutes_str = minutes(max_duration_ns)
    not days(max_duration_ns)
    not hours(max_duration_ns)
	timespan := concat(" ", [minutes_str])
}

workflow_exist(workflowName) {
   wo := input.workflows[_]
   startswith(wo.name, workflowName) 
}

schedules_exist_not_empty(workflowName) {
   wo := input.workflows[_]
   startswith(wo.name, workflowName)
   wo.schedules
   count(wo.schedules) > 0
}

is_allowed_action(action) {
    # A field is restricted if it is found in the `restricted_fields` set.
	allowed_actions[action]
}

is_allowed_netapp_space(space) {
    # A field is restricted if it is found in the `restricted_fields` set.
	allowed_netapp_spaces[space]
}

is_allowed_space_environments_per_user(space) {
    # A field is restricted if it is found in the `restricted_fields` set.
	allowed_space_environments_per_user[space]
}

is_valid_data(max_duration_minutes, duration_for_manual_minutes)
{   
    is_number(max_duration_minutes)
    is_number(duration_for_manual_minutes)
}

parameter_exist(paramName) {
   param := input.parameters[_]
   startswith(param.name, paramName) 
}

get_input_json_as_string(str,workflowName,answerExpecting){
    wo := input.inputs[_]
    startswith(wo.name, workflowName)
    wo.value = answerExpecting # "yes"    
}

check_is_netapp_need_approval(str){
    is_netapp_need_approval(str,"NetApp","yes")
}

is_netapp_need_approval(str,workflowName,answerExpecting){
    wo := input.inputs[_]
    # print("spaceName ", input.space_name)
    startswith(wo.name, workflowName)
    wo.value = answerExpecting 
    not is_allowed_netapp_space(input.space_name)
}

is_invalid_data_max_duration_minutes(){
    data.max_duration_minutes
	not is_number(data.max_duration_minutes)	
    is_allowed_action(input.action_identifier.action_type)
}

is_invalid_data_duration_for_manual_minutes(){
    data.duration_for_manual_minutes
	not is_number(data.duration_for_manual_minutes)
    is_allowed_action(input.action_identifier.action_type) 
}

is_Environment_duration_exceeds_max_duration(){
    is_valid_data(data.max_duration_minutes, data.duration_for_manual_minutes)
	data.max_duration_minutes < input.duration_minutes
    is_action_type_launch
}

is_duration_exceeds_environment_requires_approval(){
    is_valid_data(data.max_duration_minutes, data.duration_for_manual_minutes)
	data.max_duration_minutes >= input.duration_minutes
    data.duration_for_manual_minutes < input.duration_minutes
    is_action_type_launch
}

is_automatic_power_off_disabled_for_VMs(workflow_action){
    is_valid_data(data.max_duration_minutes, data.duration_for_manual_minutes)
    data.duration_for_manual_minutes >= input.duration_minutes 
    workflow_exist("PowerOff")
    not schedules_exist_not_empty("PowerOff")
    is_action_type_launch
}

is_environment_has_no_power_off_workflow(workflow_action){
    is_valid_data(data.max_duration_minutes, data.duration_for_manual_minutes)
    data.duration_for_manual_minutes >= input.duration_minutes 
    not workflow_exist(workflow_action)
    is_action_type_launch
}

is_action_type_launch(){
    input.action_identifier.action_type == "Launch"
}

is_user_4_environments(){
    is_number(input.owner_active_environments_in_space)
    input.owner_active_environments_in_space > 3
    input.owner_active_environments_in_space < 8
    is_allowed_space_environments_per_user(input.space_name)
}

is_netapp_approved(){
    input.duration_minutes
    not is_invalid_data_max_duration_minutes
    not is_invalid_data_duration_for_manual_minutes
    not is_Environment_duration_exceeds_max_duration
    not is_duration_exceeds_environment_requires_approval
    not is_automatic_power_off_disabled_for_VMs("PowerOff")
    not is_environment_has_no_power_off_workflow("PowerOff")
    is_action_type_launch
    check_is_netapp_need_approval(input)
}

#end of helper functions
# default inn := null
# inn := input
# json.marshal(input) # prints json as string

allowed_actions := {"Launch", "Extend"}

allowed_netapp_spaces := {"SE-Labs","Certification-Labs"}

allowed_space_environments_per_user := {"Support-Labs"}#, "Varonis-Labs-STG"}

default result = { "decision": "Approved"} 



result := { "decision": "Manual", "reason": "Environment has no Power Off workflow" } if {
    is_environment_has_no_power_off_workflow("PowerOff")
}

result := { "decision": "Manual", "reason": "Automatic Power Off is disabled for VMs (always on)" } if {
    is_automatic_power_off_disabled_for_VMs("PowerOff")
}

# #is used to print out the input - recommended to comment out everything else
# result := { "decision": "Manual", "reason": inputAsString } if {
#     input.duration_minutes
#     inputAsString := json.marshal(input)
# }"
