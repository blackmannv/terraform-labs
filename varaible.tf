variable "loc" {
    description = "Default Azure Region"
    default     = "westeurope"
}

variable "nlocs" {
    description = "Multi Region WebApp Location"
    type        = list(string)
    default     = ["westeurope" , "southeastasia"]
}

variable "tags" {
    default     = {
        source = "citadel"
        env    = "training"
        costcenter ="it"
    }
}