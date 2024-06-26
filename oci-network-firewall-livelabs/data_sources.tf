# ------ Get Network Compartment Name for Policies
data "oci_identity_compartment" "network_compartment" {
  id = var.network_compartment_ocid
}


# ------ Get list of availability domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

# ------ Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID" {
  compartment_id = var.compute_compartment_ocid
  # operating_system         = var.instance_os
  # operating_system_version = var.linux_os_version
  shape = var.spoke_vm_compute_shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# ------ Get the Oracle Tenancy ID
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}


# ------ Get the Tenancy ID and AD Number
data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.availability_domain_number
}

# ------ Get the Tenancy ID and ADs
data "oci_identity_availability_domains" "ads" {
  #Required
  compartment_id = var.tenancy_ocid
}

# ------ Get the Faulte Domain within AD 
data "oci_identity_fault_domains" "fds" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compute_compartment_ocid

  depends_on = [
    data.oci_identity_availability_domain.ad,
  ]
}

# ------ Get the Allow All Security Lists for Subnets in Firewall VCN
data "oci_core_security_lists" "allow_all_security_oci_network_firewall_core" {
  compartment_id = var.compute_compartment_ocid
  vcn_id         = local.use_existing_network ? var.oci_network_firewall_vcn_id : oci_core_vcn.oci_network_firewall.0.id
  filter {
    name   = "display_name"
    values = ["AllowAll"]
  }
  depends_on = [
    oci_core_security_list.allow_oci_network_firewall_core_security,
  ]
}

# ------ Get the Allow All Security Lists for Subnets in Firewall VCN
data "oci_core_security_lists" "allow_all_security_application" {
  compartment_id = var.compute_compartment_ocid
  vcn_id         = local.use_existing_network ? var.application_vcn_id : oci_core_vcn.application.0.id
  filter {
    name   = "display_name"
    values = ["AllowAll"]
  }
  depends_on = [
    oci_core_security_list.allow_all_security_application,
  ]
}

# ------ Get the OCI Network Firewall Details
data "oci_network_firewall_network_firewall" "oci_network_firewall" {
  network_firewall_id = oci_network_firewall_network_firewall.network_firewall[0].id
}

# ------ Get the Private IPs using Trust Subnet
data "oci_core_private_ips" "firewall_subnet_private_ip" {
  subnet_id = oci_core_subnet.oci_network_firewall_subnet[0].id

  filter {
    name   = "display_name"
    values = ["oci-network-firewall-demo"]
  }

  depends_on = [
    oci_network_firewall_network_firewall.network_firewall
  ]
}
