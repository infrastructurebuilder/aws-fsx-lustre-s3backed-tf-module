variable "vpc_id" {
  description = "The ID of the VPC where the FSx file system will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the FSx file system. (Provide one for single-AZ deployments)."
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to connect to the FSx file system on TCP port 988 (e.g., your VPC CIDR or client subnets)."
  type        = list(string)
}

variable "s3_bucket_name" {
  description = "The name of the existing S3 bucket to use as the data repository."
  type        = string
}

variable "s3_import_prefix" {
  description = "An optional prefix within the S3 bucket to import data from. Leave blank for the root of the bucket."
  type        = string
  default     = ""
}

variable "s3_export_prefix" {
  description = "The prefix within the S3 bucket to export modified data to."
  type        = string
  default     = "fsx-export/"
}

variable "storage_capacity" {
  description = "The storage capacity of the file system in GiB. Must be 1200, 2400, or a multiple of 2400 for PERSISTENT_1."
  type        = number
  default     = 1200
}

variable "deployment_type" {
  description = "The file system deployment type (SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2)."
  type        = string
  default     = "PERSISTENT_1"
}

variable "per_unit_storage_throughput" {
  description = "Required for PERSISTENT deployment types. Throughput per TiB (50, 100, 250)."
  type        = number
  default     = 50
}