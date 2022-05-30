## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_core_vnic_attachments" "devbox_vnics" {
  compartment_id      = oci_identity_compartment.devbox_compartment.id
  availability_domain = var.availablity_domain_name 
  instance_id         = oci_core_instance.devbox.id
}

data "oci_core_vnic" "devbox_vnic" {
  vnic_id = lookup(data.oci_core_vnic_attachments.devbox_vnics.vnic_attachments[0], "vnic_id")
}

data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.instance_shape
}


data "oci_identity_region_subscriptions" "home_region_subscriptions" {
    tenancy_id = var.tenancy_ocid

    filter {
      name   = "is_home_region"
      values = [true]
    }
}