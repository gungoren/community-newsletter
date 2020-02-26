variable "bucket" {}

variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = string
}

variable "timeout" {
  default = 300
}

variable "web_page_user" {}
