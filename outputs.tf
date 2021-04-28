
###
# compute.tf outputs
###

output "instance_id" {
  value = oci_core_instance.simple-vm.*.id
}

output "instance_public_ip" {
  value = oci_core_instance.simple-vm.*.public_ip
}

output "instance_private_ip" {
  value = oci_core_instance.simple-vm.*.private_ip
}

output "vcn_cidr_block" {
  value = !local.use_existing_network ? join("", oci_core_vcn.simple.*.cidr_block) : var.vcn_cidr_block
}

output "message" {
  value = "It may take some minutes to complete Runner installation and registration process. You can SSH to the instance and check log messages through `sudo cat /var/log/messages` or `sudo tail -f /var/log/messages` [Ctrl+C to exit]. Once registered, the Runner should be visible on your GitHub repo /settings/actions."
}