variable "some_string" {
default = "Vinay"
  
}

variable "some_number" {
    default = 1
  
}

output "some_string" {
   value= var.some_string
  
}