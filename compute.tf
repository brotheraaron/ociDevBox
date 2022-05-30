## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "template_file" "devbox" {
  template = file("./scripts/devbox.sh")

  vars = {
    ssh_public_key = tls_private_key.public_private_key_pair.public_key_openssh
  }

}

resource "oci_core_instance" "devbox" {
  availability_domain = var.availablity_domain_name
  compartment_id      = oci_identity_compartment.devbox_compartment.id
  display_name        = "devbox"
  shape               = var.instance_shape
  
  dynamic "shape_config" {
    for_each = local.is_flexible_shape ? [1] : []
    content {
      memory_in_gbs = var.instance_flex_shape_memory
      ocpus = var.instance_flex_shape_ocpus
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.devboxSubnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "devbox"
  }

  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
    user_data           = base64encode(data.template_file.devbox.rendered)
  }

  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# resource "null_resource" "remote-exec" {
#   depends_on = ["oci_core_instance.devbox"]   
    
#   provisioner "remote-exec" {
#       connection {
#           agent = false
#           timeout = "10m"
#           host = "${oci_core_instance.devbox.public_ip}"
#           user = "${var.opc_user_name}"
#           private_key = "${tls_private_key.public_private_key_pair.private_key_pem}"
#         }
#       inline = [
#           "shutdown -r +10"
#         ]
#     }
# }
