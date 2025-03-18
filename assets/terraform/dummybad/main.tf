variable "sleep" {
  default = "1s" 
}

variable "mandatoryInput" {
}

resource "time_sleep" "wait_10_sec" {
  create_duration = var.sleep
}

output "sleep_out" {
  value = var.sleep 
}
