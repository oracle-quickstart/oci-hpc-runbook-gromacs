data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
    tenancy_id = var.tenancy_ocid

    filter {
      name   = "is_home_region"
      values = [true]
    }
}

data "oci_core_vnic_attachments" "GPU_Instance_Primary_VNIC_Attach" {
  count               = var.gpu_node_count
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  instance_id         = oci_core_instance.GPU_Instance[count.index].id
}

data "oci_core_vnic" "GPU_Instance_Primary_VNIC" {
  count   = var.gpu_node_count
  vnic_id = data.oci_core_vnic_attachments.GPU_Instance_Primary_VNIC_Attach[count.index].vnic_attachments.0.vnic_id
}

# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.gpu_shape

  filter {
    name   = "display_name"
    values = ["^.*Gen2-GPU[^G]*$"]
    regex  = true
  }
}
