## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_virtual_network" "devboxVCN" {
  cidr_block     = var.VCN-CIDR
  compartment_id      = oci_identity_compartment.devbox_compartment.id
  display_name   = "devboxVCN"
  dns_label      = "devboxvcn"
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "devboxSubnet" {
  availability_domain = var.availablity_domain_name
  cidr_block          = var.devboxSubnet-CIDR
  display_name        = "devboxSubnet"
  dns_label           = "devboxsubnet"
  security_list_ids   = [oci_core_security_list.devboxSecurityList.id]
  compartment_id      = oci_identity_compartment.devbox_compartment.id
  vcn_id              = oci_core_virtual_network.devboxVCN.id
  route_table_id      = oci_core_route_table.devboxRT.id
  dhcp_options_id     = oci_core_virtual_network.devboxVCN.default_dhcp_options_id
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_internet_gateway" "devboxIG" {
  compartment_id      = oci_identity_compartment.devbox_compartment.id
  display_name   = "devboxIG"
  vcn_id         = oci_core_virtual_network.devboxVCN.id
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_route_table" "devboxRT" {
  compartment_id      = oci_identity_compartment.devbox_compartment.id
  vcn_id         = oci_core_virtual_network.devboxVCN.id
  display_name   = "devboxRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.devboxIG.id
  }
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
