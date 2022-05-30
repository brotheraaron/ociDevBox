module "iam_dynamic_group" {
  version                   = "2.0.1"
  source                    = "oracle-terraform-modules/iam/oci//modules/iam-dynamic-group"
  tenancy_ocid              = var.tenancy_ocid
  dynamic_group_name        = "devbox_dynamic_group"
  dynamic_group_description = "Add devbox instance OCIDs to this group"
  matching_rule             = "instance.id = '${oci_core_instance.devbox.id}'"
  policy_compartment_id     = oci_identity_compartment.devbox_compartment.id
  policy_name               = "devbox-dynamic-policy"
  policy_description        = "dynamic policy gives devbox VM permissions to everything in devbox compartment"
  policy_statements         = [
    "Allow dynamic-group ${module.iam_dynamic_group.dynamic_group_name} to manage all-resources in compartment ${var.compartment_name}"
  ]
}