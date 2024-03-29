variable "env" {
  type    = string
  default = "undefined_env"
}

variable "sns_email" {
  type        = list(string)
  description = "Email used to subscribe to events notifications"
  default     = ["bogdanpetrovich123@gmail.com"]
}



