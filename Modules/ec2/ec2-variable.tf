variable "sg_id" {
  description = "SG ID for Ec2"
  type        = string
}

variable "subnets" {
  type = list(string)
}

variable "ec2-name" {
  type    = list(string)
  default = ["ec2-1", "ec2-2"]

}