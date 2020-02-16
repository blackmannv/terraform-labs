variable "loc" {
    description = "Default Azure Region"
    default     = "westeurope"
}

variable "tags" {
    default     = {
        source = "citadel"
        env    = "training"
        costcenter ="it"
    }
}