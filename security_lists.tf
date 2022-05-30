## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_security_list" "devboxSecurityList" {
  compartment_id = oci_identity_compartment.devbox_compartment.id
  vcn_id         = oci_core_virtual_network.devboxVCN.id
  display_name   = "devboxSecurityList"

  # Note to self:
  #  ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58"). 
  egress_security_rules {
      protocol    = "6"
      destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }   
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
