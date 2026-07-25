module "fsx_with_s3" {
  source = "../.." # "git::https://github.com/infrastructurebuilder/aws-fsx-lustre-s3backed-tf-module.git"

  vpc_id              = "vpc-0abc123def456"
  subnet_ids          = ["subnet-0abc1234567"]
  allowed_cidr_blocks = ["10.0.0.0/16"] # Your VPC CIDR range
  
  # The name of your existing bucket
  s3_bucket_name      = "my-existing-training-data-bucket"
  
  # Optional overrides
  storage_capacity    = 2400
  deployment_type     = "PERSISTENT_1"
}