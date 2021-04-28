#Variables declared in this file must be declared in the marketplace.yaml
#Provide a description to your variables.

############################
#  Hidden Variable Group   #
############################
variable "tenancy_ocid" {
}

variable "region" {
}


############################
#  Compute Configuration   #
############################

variable "compute_image_strategy" {
  description = "Use either Platform Image or Custom Image"
  default     = "Platform Image"
}

variable "vm_display_name" {
  description = "Instance Name"
  default     = "oci-github-runner"
}

variable "compute_shape" {
  description = "Compute Shape"
  default     = ""
}

variable "flex_shape_ocpus" {
  description = "Flex Shape OCPUs"
  default     = 1
}

variable "flex_shape_memory" {
  description = "Flex Shape Memory"
  default     = 6
}

variable "availability_domain_name" {
  default     = ""
  description = "Availability Domain"
}

variable "ad_number" {
  default     = 1
  description = "OCI Availability Domains: 1,2,3  (subject to region availability)"
}

variable "ssh_public_key" {
  description = "SSH Public Key"
}

variable "hostname_label" {
  default     = "githubrunner"
  description = "DNS Hostname Label. Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123."
}



############################
#  GuestOS Configuration   #
############################

variable "platform_image_ocid" {
  description = "Select the Compute Platform Image ocid available for this particular region"
  default     = ""
}

variable "custom_image_ocid" {
  description = "Enter the Compute Custom Image ocid available for this particular region based on selected Operating System."
  default     = ""
}

############################
#  Github Configuration    #
############################

variable "github_runner_version" {
  description = "Enter the Github Runner Version in the format of .n.nnn.n e.g. 2.278.0. Releases: https://github.com/actions/runner/releases"
  default     = "2.278.0"
}

variable "github_url" {
  description = "Enter the Github Organization or Repo URL in the format of 'https://github.com/<github-organization>/<github-repo>/' "
  default     = ""
}

variable "github_runner_registration_token" {
  description = "Enter the Github Runner Registration token"
  default     = ""
}

variable "number_of_runners" {
  description = "Enter the number of runners"
  default     = 1
}

// variable "github_runner_docker_image" {
//   description = "Enter default Docker image for github Runner"
//   default = "ubuntu:latest"  
// }


variable "github_runner_label_list" {
  description = "github Runner Label List (separated by comma)"
  default     = "oci"
}

############################
#  Network Configuration   #
############################

variable "network_strategy" {
  #default = "Use Existing VCN and Subnet"
  default = "Create New VCN and Subnet"
}

variable "vcn_id" {
  default = ""
}

variable "vcn_display_name" {
  description = "VCN Name"
  default     = "github-runner-vcn"
}

variable "vcn_cidr_block" {
  description = "VCN CIDR"
  default     = "10.0.0.0/16"
}

variable "vcn_dns_label" {
  description = "VCN DNS Label"
  default     = "githubrunner"
}

variable "subnet_type" {
  description = "Choose between private and public subnets"
  default     = "Public Subnet"
  #or  
  #default     = "Private Subnet"
}

variable "subnet_id" {
  default = ""
}

variable "subnet_display_name" {
  description = "Subnet Name"
  default     = "github-runner-subnet"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR"
  default     = "10.0.0.0/24"
}

variable "subnet_dns_label" {
  description = "Subnet DNS Label"
  default     = "githubrunnersub"
}


############################
# Security Configuration #
############################
variable "nsg_display_name" {
  description = "Network Security Group Name"
  default     = "github-runner-nsg"
}

variable "nsg_source_cidr" {
  description = "Allowed Ingress Traffic (CIDR Block)"
  default     = "0.0.0.0/0"
}

variable "nsg_ssh_port" {
  description = "SSH Port"
  default     = 22
}

variable "nsg_https_port" {
  description = "HTTPS Port"
  default     = 443
}

variable "nsg_http_port" {
  description = "HTTP Port"
  default     = 80
}

############################
# Additional Configuration #
############################

variable "compute_compartment_ocid" {
  description = "Compartment where Compute resources will be created"
}

variable "network_compartment_ocid" {
  description = "Compartment where Network resources will be created"
}

variable "tag_key_name" {
  description = "Free-form tag key name"
  default     = "oracle-quickstart"
}

variable "tag_value" {
  description = "Free-form tag value"
  default     = "oci-github-actions-runner"
}


######################################################################################
#    Enum - Map keys are used on locals.tf and Map values are defined on orm.yaml    #
#####################################################################################

variable "compute_image_strategy_enum" {
  type = map(any)
  default = {
    PLATFORM_IMAGE = "Platform Image"
    CUSTOM_IMAGE   = "Custom Image"
  }
}

variable "network_strategy_enum" {
  type = map(any)
  default = {
    CREATE_NEW_VCN_SUBNET   = "Create New VCN and Subnet"
    USE_EXISTING_VCN_SUBNET = "Use Existing VCN and Subnet"
  }
}

variable "subnet_type_enum" {
  type = map(any)
  default = {
    PRIVATE_SUBNET = "Private Subnet"
    PUBLIC_SUBNET  = "Public Subnet"
  }
}

variable "nsg_config_enum" {
  type = map(any)
  default = {
    BLOCK_ALL_PORTS = "Block all ports"
    OPEN_ALL_PORTS  = "Open all ports"
    CUSTOMIZE       = "Customize ports - Post deployment"
  }
}
