terraform {
    backend "s3" {
       bucket = "gitlab-april-2019"
       region = "eu-west-1"
       key = "Env/state"  
    }
}