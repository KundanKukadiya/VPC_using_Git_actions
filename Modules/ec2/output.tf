output "instance" {
  value = aws_instance.my-ec2.*.id
}