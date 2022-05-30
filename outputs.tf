## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "devbox_VM_public_IP" {
  value = data.oci_core_vnic.devbox_vnic.public_ip_address
}

output "generated_ssh_private_key" {
  value = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "instance_ocid" {
  value = oci_core_instance.devbox.id
}

output "user_data_maybe" {
  value = data.template_file.devbox.rendered
}


