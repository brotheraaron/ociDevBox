resource "oci_identity_compartment" "devbox_compartment" {
    #Required
    compartment_id = var.tenancy_ocid
    description = var.compartment_description
    name = var.compartment_name
}