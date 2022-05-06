/*variable "env"{
    type = string
    description = "Deploy Environment"
    default = "dev"
}*/

variable image {
    type = map
    description = "Image for Container"
    default = {
        dev = "nodered/node-red:latest"
        prod = "nodered/node-red:latest-minimal"
    }
    
}


variable "ext_port"{
  type = map
  description = "Container port"
  #sensitive = true
  validation {
    condition = max(var.ext_port["dev"]...) <=65535 && min(var.ext_port["dev"]...) > 1900
    error_message = "The port value should be 1880."
  
 }
 
  validation {
    condition = max(var.ext_port["prod"]...) <=1980 && min(var.ext_port["prod"]...) >=1880
    error_message = "The port value should be 1880."
  
 }
    
}

locals {
    conatiner_count = length(var.ext_port[terraform.workspace])
}