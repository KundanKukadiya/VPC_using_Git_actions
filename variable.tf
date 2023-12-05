variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnets" {
  description = "Subnets range"
  type        = list(string)
}