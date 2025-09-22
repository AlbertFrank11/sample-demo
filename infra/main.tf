# main.tf

# --- Provider Block ---
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/root/.aws/credentials"]
}

# --- Resource Block ---
resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "app-server"
  }
}

