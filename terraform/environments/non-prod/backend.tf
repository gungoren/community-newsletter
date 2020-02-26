provider aws {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "community-newsletter-app-state-2"
    key    = "terraform/dev/terraform_dev.tfstate"
    region = "eu-west-2"
  }
}
