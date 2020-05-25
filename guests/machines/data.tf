data "terraform_remote_state" "images" {
  backend = "local"
  config = {
    path = "${path.module}/../images/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking" {
  backend = "local"
  config = {
    path = "${path.module}/../networking/terraform.tfstate"
  }
}

data "terraform_remote_state" "storage" {
  backend = "local"
  config = {
    path = "${path.module}/../storage/terraform.tfstate"
  }
}

data "terraform_remote_state" "cloudinit" {
  backend = "local"
  config = {
    path = "${path.module}/../configs/terraform.tfstate"
  }
}
