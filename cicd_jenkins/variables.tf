variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "zone_name" {
  type        = string
  default     = "venaws.site"
  description = "description"
}

variable "zone_id" {
  type        = string
  default     = "Z05167558BEIFU213OL8"
  description = "description"
}