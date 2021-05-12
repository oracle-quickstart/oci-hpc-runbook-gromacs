## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "region" { }
variable "tenancy_ocid" { }
variable "compartment_ocid" { }
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "availablity_domain_name" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.0"
}

variable "gpu_node_count" {
    default = "1"
}

variable "vnc_password" {
    default = "HPC_oci1"
}

variable "gpu_shape" { 
  default = "VM.GPU2.1"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "Subnet-CIDR" {
  default = "10.0.0.0/24"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.9"
}

# Possible values are none, vnc or x11vnc
# If x11vnc is selected and NVIDIA drivers are not available, vnc will be used.
variable "gpu_vnc" { 
    default = "vnc"
}

# Install Block NFS, value are 0 or 1
variable "block_nfs" {
  default = "True"
}

# Size in GB
variable "size_block_volume" {
  default = "1000"
}

variable "model_drive" {
  default = "block"
}

variable "devicePath" {
  default = "/dev/oracleoci/oraclevdb"
}

locals {
#  os_user = replace(var.gpu_shape, "GPU", "") != var.gpu_shape ? "ubuntu" : "opc"
   os_user = var.instance_os != "Oracle Linux" ? "ubuntu" : "opc"
}

variable "gromacs_url" { 
    default = "https://objectstorage.us-phoenix-1.oraclecloud.com/p/1qRcaB09pZAn7g3Fr878xpO_grM2z3-bYr5yPCEkhSy4ESHW8_gd-91nnVuSYcQ6/n/hpc/b/HPC_APPS/o/gromacs-compiled-2020.1.tar"
}

variable "model_url" { 
    default = "https://objectstorage.us-phoenix-1.oraclecloud.com/p/fyZU6e7ttYgjTGIQNnPNUG6btTkkUyDyG1K1qNEQJpE/n/hpc/b/HPC_APPS/o/gromacs_benchMEM.tpr"
}

variable "visualizer_url" { 
    default = "https://objectstorage.us-phoenix-1.oraclecloud.com/p/bpR0VM0GaNlc4yQsGLwO4lZwneKxXwN8vUdtyKcVZcE/n/hpc/b/HPC_APPS/o/vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz"
}