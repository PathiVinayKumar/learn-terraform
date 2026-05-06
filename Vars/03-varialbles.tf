variable "some_string" {
default = "Vinay"
  
}

variable "some_number" {
    default = 1
  
}

variable "list" {
    default ={
        x-=100
        y=200
        name= " VInay "
        c= false
    }

  
}

output "some_string" {
   value= var.some_string
  
}

output "some_number" {
    value = var.some_number
}

