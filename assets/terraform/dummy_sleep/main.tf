variable "sleep" {
  default = "3s" 
}

resource "time_sleep" "wait_10_sec" {
  create_duration = var.sleep
}

output "sleep_out" {
  value = var.sleep 
}
