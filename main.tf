terraform {
  required_version = ">= 1.9.2"
}

# Define a simple local variable
locals {
  message = "Hello, World!"
}

# Output the message
output "hello_world" {
  value = local.message
}
