resource "oci_core_instance" "simple-vm" {
  count               = var.number_of_runners
  availability_domain = local.availability_domain
  compartment_id      = var.compute_compartment_ocid
  display_name        = "${var.vm_display_name}-${count.index}"
  shape               = local.compute_shape

  dynamic "shape_config" {
    for_each = local.is_flex_shape
    content {
      ocpus         = local.flex_shape_ocpus
      memory_in_gbs = local.flex_shape_memory
    }
  }


  create_vnic_details {
    subnet_id              = local.use_existing_network ? var.subnet_id : oci_core_subnet.simple_subnet[0].id
    display_name           = "${var.subnet_display_name}-${count.index}"
    assign_public_ip       = local.is_public_subnet
    hostname_label         = "${var.hostname_label}-${count.index}"
    skip_source_dest_check = false
    nsg_ids                = [oci_core_network_security_group.simple_nsg.id]
  }

  source_details {
    source_type = "image"
    source_id   = local.image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(join("\n", tolist([
      "#!/usr/bin/env bash",
      "set -x",
      (data.template_file.install_runner_ol.rendered)],
    )))
  }

  freeform_tags = tomap({ "${var.tag_key_name}" = "${var.tag_value}" })
}


data "template_file" "install_runner_ol" {
  template = file("${path.module}/scripts/install-github-runner-OL.sh")

  vars = {
    github_runner_version            = var.github_runner_version
    github_runner_registration_token = var.github_runner_registration_token
    github_url                       = var.github_url
    github_runner_label_list         = var.github_runner_label_list
  }
}
