variables {
  bucket_name = "tftest-s3-bucket"
  tags = {
    Environment = "test"
    ManagedBy   = "terraform"
  }
}

run "verify_bucket_config" {
  command = plan

  assert {
    condition     = aws_s3_bucket.this.bucket == "tftest-s3-bucket"
    error_message = "Bucket name did not match expected value"
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Enabled"
    error_message = "Bucket versioning is not enabled"
  }

  assert {
    condition     = [for r in aws_s3_bucket_server_side_encryption_configuration.this.rule : r.apply_server_side_encryption_by_default[0].sse_algorithm][0] == "AES256"
    error_message = "Bucket encryption is not enabled with AES256"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.block_public_acls == true
    error_message = "Public ACLs are not blocked"
  }
}
