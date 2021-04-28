locals {
  # Logic to use AD name provided by user input on ORM or to lookup for the AD name when running from CLI
  availability_domain = (var.availability_domain_name != "" ? var.availability_domain_name : data.oci_identity_availability_domain.ad.name)

  # local.use_existing_network referenced in network.tf
  use_existing_network = var.network_strategy == var.network_strategy_enum["USE_EXISTING_VCN_SUBNET"] ? true : false

  # local.is_public_subnet referenced in compute.tf
  is_public_subnet = var.subnet_type == var.subnet_type_enum["PUBLIC_SUBNET"] ? true : false

  compute_shape = var.compute_shape

  flex_shape_ocpus = var.flex_shape_ocpus

  flex_shape_memory = var.flex_shape_memory

  is_flex_shape = length(regexall("Flex", local.compute_shape)) > 0 ? [1] : []

  image_id = var.compute_image_strategy == var.compute_image_strategy_enum["PLATFORM_IMAGE"] ? var.platform_image_ocid : var.custom_image_ocid

}
