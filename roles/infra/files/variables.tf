variable "vpc_cidr" {
    default = "10.144.0.0/16"
}
variable "subnet_cidr" {
    default = "10.144.0.0/18"
}
variable "ami" {
    default = "ami-0f6ac851567cee28d"
}
variable "nodeport" {
    default = "30000"
}
variable "accessip" {
    default = "90.247.196.122/32"
}

variable "names" {
  default = ["k8sm1", "k8sn1", "k8sn2"]
}

variable "region" {
    default = "eu-west-1"
}
