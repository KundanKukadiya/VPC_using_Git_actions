variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnets" {
  description = "Subnets range"
  type        = list(string)
}

variable "subnets_names" {
  description = "Subnets az zones"
  type        = list(string)
  default     = ["Public1", "Public2"]
}