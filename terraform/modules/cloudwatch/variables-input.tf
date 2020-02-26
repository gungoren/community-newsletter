variable "function_name" {
    type = string
}

variable "function_arn" {
    type = string
}

variable "event_name" {
  type = string
}

variable "schedule_midnight" {
  default = "cron(0 0 * * ? *)"
}

variable "web_page_user" {}