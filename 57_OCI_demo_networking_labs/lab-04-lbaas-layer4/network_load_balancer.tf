## This configuration was generated by terraform-provider-oci

resource oci_network_load_balancer_network_load_balancer nlb_demo57_vtap {
  compartment_id = var.compartment_ocid
  display_name = "nlb_demo57_vtap"
  is_preserve_source_destination = "false"
  is_private                     = "false"
  is_symmetric_hash_enabled      = "false"
  network_security_group_ids = [
  ]
  nlb_ip_version = "IPV4"
  subnet_id = oci_core_subnet.pub_subnet1.id
}

resource oci_network_load_balancer_backend_set backendset_demo57_vtap {
  health_checker {
    interval_in_millis = "10000"
    port               = "0"
    protocol           = "HTTP"
    response_body_regex = ""
    retries           = "3"
    return_code       = "200"
    timeout_in_millis = "3000"
    url_path          = "/"
  }
  ip_version                  = "IPV4"
  is_fail_open                = "false"
  is_instant_failover_enabled = "false"
  is_preserve_source          = "true"
  name                        = "backendset_demo57_vtap"
  network_load_balancer_id    = oci_network_load_balancer_network_load_balancer.nlb_demo57_vtap.id
  policy                      = "FIVE_TUPLE"
}

resource oci_network_load_balancer_backend ocid1-privateip-80 {
  backend_set_name         = oci_network_load_balancer_backend_set.backendset_demo57_vtap.name
  ip_address               = "10.12.2.95"
  is_backup                = "false"
  is_drain                 = "false"
  is_offline               = "false"
  name                     = "ocid1-privateip-80"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.nlb_demo57_vtap.id
  port                     = "80"
  target_id                = oci_core_instance.monitor-1.id
  weight                   = "1"
}

resource oci_network_load_balancer_listener nlb_demo57_vtap_listener_demo57_vtap {
  default_backend_set_name = oci_network_load_balancer_backend_set.backendset_demo57_vtap.name
  ip_version               = "IPV4"
  name                     = "listener_demo57_vtap"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.nlb_demo57_vtap.id
  port                     = "80"
  protocol                 = "TCP_AND_UDP"
}
