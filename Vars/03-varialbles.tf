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

resource "null_resource" "test" {
    for_each = var.list

}


