data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket = "bc-sthree-${data.aws_caller_identity.current.account_id}-01"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.this.id
  key    = "index.html"
  source = "./index.html"

  tags = {
    Name        = "My bucket object"
    Environment = "Dev"
  }
}