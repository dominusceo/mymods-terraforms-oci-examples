# ------ Create a new VCN
resource oci_core_vcn vcn3-vcn {
  cidr_blocks    = [ var.vcn3_cidr_vcn ]
  compartment_id = var.compartment_ocid
  display_name   = "tf-demo12d-vcn3"
  dns_label      = var.dns_label_vcn3
}

# ------ Attach common DRG to VCN
resource oci_core_drg_attachment vcn3 {
  drg_id       = oci_core_drg.commong_drg.id
  vcn_id       = oci_core_vcn.vcn3-vcn.id
  display_name = "common-drg_to_vcn3"
}

# ------ Create a new Internet Gategay
resource oci_core_internet_gateway vcn3-ig {
  compartment_id = var.compartment_ocid
  display_name   = "demo12d_vcn3_igw"
  vcn_id         = oci_core_vcn.vcn3-vcn.id
}

# ------ Create a new Route Table for the public subnet
resource oci_core_route_table vcn3-pubnet-rt {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn3-vcn.id
  display_name   = "demo12d_vcn3_pubnet_rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.vcn3-ig.id
  }

  route_rules {
    destination       = var.vcn1_cidr_vcn
    network_entity_id = oci_core_drg.commong_drg.id
  }

  route_rules {
    destination       = var.vcn2_cidr_vcn
    network_entity_id = oci_core_drg.commong_drg.id
  }
}

# ------ Create a new Route Table for the private subnet
resource oci_core_route_table vcn3-privnet-rt {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn3-vcn.id
  display_name   = "demo12d_vcn3_privnet_rt"

  route_rules {
    destination       = var.vcn1_cidr_vcn
    network_entity_id = oci_core_drg.commong_drg.id
  }

  route_rules {
    destination       = var.vcn2_cidr_vcn
    network_entity_id = oci_core_drg.commong_drg.id
  }
}

# ------ Create a new security list to be used in the new public subnet
resource oci_core_security_list vcn3-pubnet-sl {
  compartment_id = var.compartment_ocid
  display_name   = "demo12d_vcn3_pubnet_sl"
  vcn_id         = oci_core_vcn.vcn3-vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn1_cidr_vcn
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn2_cidr_vcn
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn3_cidr_vcn
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = var.authorized_ips

    tcp_options {
      min = 22
      max = 22
    }
  }
  # needed. See https://docs.cloud.oracle.com/iaas/Content/Network/Troubleshoot/connectionhang.htm?Highlight=MTU#Path
  ingress_security_rules {
    protocol = "1" # icmp
    source   = var.authorized_ips

    icmp_options {
      type = 3
      code = 4
    }
  }
}

# ------ Create a new security list to be used in the new private subnet
resource oci_core_security_list vcn3-privnet-sl {
  compartment_id = var.compartment_ocid
  display_name   = "demo12d_vcn3_privnet_sl"
  vcn_id         = oci_core_vcn.vcn3-vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn1_cidr_vcn
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn2_cidr_vcn
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn3_cidr_vcn
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = var.authorized_ips

    tcp_options {
      min = 22
      max = 22
    }
  }
}

# ------ Create a public subnet in the new VCN
resource oci_core_subnet vcn3-pubnet {
  cidr_block          = var.vcn3_cidr_pubnet
  display_name        = "demo12d_vcn3_pubnet"
  dns_label           = var.dns_label_public2
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn3-vcn.id
  route_table_id      = oci_core_route_table.vcn3-pubnet-rt.id
  security_list_ids   = [oci_core_security_list.vcn3-pubnet-sl.id]
  dhcp_options_id     = oci_core_vcn.vcn3-vcn.default_dhcp_options_id
}

# ------ Create a private subnet in the new VCN
resource oci_core_subnet vcn3-privnet {
  cidr_block          = var.vcn3_cidr_privnet
  display_name        = "demo12d_vcn3_privnet"
  dns_label           = var.dns_label_private2
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn3-vcn.id
  route_table_id      = oci_core_route_table.vcn3-privnet-rt.id
  security_list_ids   = [oci_core_security_list.vcn3-privnet-sl.id]
  dhcp_options_id     = oci_core_vcn.vcn3-vcn.default_dhcp_options_id
}