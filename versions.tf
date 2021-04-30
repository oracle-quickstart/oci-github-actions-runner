terraform {

  required_version = ">= 0.14"

  required_providers {
    oci = {
      version = ">= 4.24"
    }
    template = {
      version = ">= 2.2"
    }

  }
}
