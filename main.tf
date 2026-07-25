# 1. Ensure the S3 bucket exists (Data Source)
data "aws_s3_bucket" "repo" {
  bucket = var.s3_bucket_name
}

# 2. Security Group for the Lustre file system
resource "aws_security_group" "fsx_sg" {
  name_prefix = "fsx-lustre-sg-"
  description = "Allow Lustre client traffic to FSx on port 988"
  vpc_id      = var.vpc_id

  # Lustre uses TCP port 988
  ingress {
    from_port   = 988
    to_port     = 988
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fsx-lustre-sg"
  }
}

# 3. The FSx for Lustre File System
resource "aws_fsx_lustre_file_system" "main" {
  storage_capacity            = var.storage_capacity
  subnet_ids                  = var.subnet_ids
  security_group_ids          = [aws_security_group.fsx_sg.id]
  deployment_type             = var.deployment_type
  per_unit_storage_throughput = var.deployment_type == "PERSISTENT_1" || var.deployment_type == "PERSISTENT_2" ? var.per_unit_storage_throughput : null

  # Data Repository Integration (S3)
  import_path = var.s3_import_prefix == "" ? "s3://${data.aws_s3_bucket.repo.id}" : "s3://${data.aws_s3_bucket.repo.id}/${var.s3_import_prefix}"
  export_path = "s3://${data.aws_s3_bucket.repo.id}/${var.s3_export_prefix}"

  # Automatically syncs newly created, modified, or deleted files from S3 to FSx
  auto_import_policy = "NEW_CHANGED_DELETED"

  tags = {
    Name = "LustreS3Integration"
  }
}