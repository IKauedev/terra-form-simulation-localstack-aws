provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true

  endpoints {
    s3         = "http://localhost:4566"
    dynamodb   = "http://localhost:4566"
    sqs        = "http://localhost:4566"
    lambda     = "http://localhost:4566"
    apigateway = "http://localhost:4566"
    logs       = "http://localhost:4566"
    iam        = "http://localhost:4566"
  }
}