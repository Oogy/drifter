data "terraform_remote_state" "images" {    
    backend = "local"                       
    config = {                              
        path = "${path.module}/../images/terraform.tfstate"                             
    }                                       
}  

module "vultr_workstation" {
  source = "../modules/disk-image"          
                                            
  disk_name     = "vultr-workstation"                                          
  base_image_id = data.terraform_remote_state.images.outputs.ubuntu_bionic
  size_gb = 30                           
}   

