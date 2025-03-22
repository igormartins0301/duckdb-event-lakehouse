variable "environment" {
  description = "The environment to deploy (e.g., dev, prd)"
  type        = string
}

# variables.tf
variable "company_name" {
  description = "Nome da empresa para prefixo do bucket"
  type        = string
  default     = "duckdb-lakehouse"
}

variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-2"
}