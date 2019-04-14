terraform {
  backend "s3" {
    key = "dev/state.tfstate"
    encrypt = true
  }
}
