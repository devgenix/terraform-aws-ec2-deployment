terraform {
  backend "s3" {
    bucket         = "savyops-tf-state-bucket-devgenix"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "savyops-tf-state-lock"
    encrypt        = true
  }
}
