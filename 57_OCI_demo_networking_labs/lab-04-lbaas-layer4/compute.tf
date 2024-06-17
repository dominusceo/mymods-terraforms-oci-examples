resource "oci_core_instance" "webserver_node" {
  count               = 2
  availability_domain = var.ad-domain
  compartment_id      = var.compartment_ocid
  shape               = var.instance_shape
  display_name = "webserver-${count.index + 1}"

  source_details {
    #All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    source_id   = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaaubny6r5o3e3ejhn6klfhdt3pveien5ohxvvd54ugy6wspxa5wb6a"
    source_type = "image"
  }
  shape_config {
    #Optional
    memory_in_gbs = "8"
    ocpus = "4"
  }
  
  create_vnic_details {
    subnet_id = oci_core_subnet.priv_subnet2.id
    assign_public_ip = "false"
    skip_source_dest_check = "true"
    display_name = "vnic-webserver-${count.index + 1}"
  }
  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
    user_data           = base64encode(var.user-data)
  }
}
resource oci_core_instance monitor-1 {
  compartment_id = var.compartment_ocid
  availability_domain = var.ad-domain
  shape = var.instance_shape
  display_name = "monitor-1"
  agent_config {
    are_all_plugins_disabled = "false"
    is_management_disabled   = "false"
    is_monitoring_disabled   = "false"
    plugins_config {
      desired_state = "ENABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Hub Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Management Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Cloud Guard Workload Protection"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Block Volume Management"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
  create_vnic_details {
    assign_public_ip = "false"
    skip_source_dest_check = "true"
    display_name = "vnic-monitor"
    private_ip             = "10.12.2.95"
    subnet_id              = oci_core_subnet.priv_subnet2.id
  }
  source_details {
    #All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    source_id   = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaaubny6r5o3e3ejhn6klfhdt3pveien5ohxvvd54ugy6wspxa5wb6a"
    source_type = "image"
  }
  shape_config {
    #Optional
    memory_in_gbs = "8"
    ocpus = "4"
  }
    metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
    user_data           = base64encode(var.user-monitor-data)
  }
}
resource "oci_core_instance" "bastion" {
  availability_domain = var.ad-domain
  compartment_id      = var.compartment_ocid
  shape               = var.instance_shape
  display_name        = "bastion"

  source_details {
    #All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    source_id   = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaaubny6r5o3e3ejhn6klfhdt3pveien5ohxvvd54ugy6wspxa5wb6a"
    source_type = "image"
  }
  shape_config {
    #Optional
    memory_in_gbs = "8"
    ocpus = "4"
  }
  
  create_vnic_details {
    subnet_id = oci_core_subnet.pub_subnet1.id
    assign_public_ip = "true"
    skip_source_dest_check = "true"
    display_name = "vnic-bastion"
  }
  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
    user_data           = base64encode(var.user-data)
  }
}