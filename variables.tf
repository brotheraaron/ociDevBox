## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {
  default = ""
}
variable "user_ocid" {
  default = ""
}
variable "fingerprint" {
  default = ""
}
variable "private_key_path" {
  default = ""
}
variable "region" {
  default = "us-sanjose-1"
}
variable "compartment_ocid" {
  default = ""
}
variable "availablity_domain_name" {
  default = "EEph:US-SANJOSE-1-AD-1"
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

variable "ssh_public_key" {
  default = ""
}

variable "VCN-CIDR" {
  default = "10.1.0.0/16"
}

variable "devboxSubnet-CIDR" {
  default = "10.1.20.0/24"
}

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}

variable "instance_flex_shape_ocpus" {
    default = 1
}

variable "instance_flex_shape_memory" {
    default = 1
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux Cloud Developer"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "8"
}

variable "compartment_description" {
  default = "Compartment for devbox resources"
}

variable "compartment_name" {
  default = "devbox"
}

variable "opc_user_name" {
  default = "opc"
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E2.1.Micro",
    "VM.Standard.E4.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_shape = contains(local.compute_flexible_shapes, var.instance_shape)
}


