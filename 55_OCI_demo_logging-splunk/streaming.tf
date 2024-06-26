## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
## Stream and StreamPool for vcn
resource "oci_streaming_stream_pool" "splunk_vcn_flow_logs_stream_pool" {
  compartment_id = var.compartment_ocid
  name           = "splunk_stream_pool"
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_streaming_stream" "splunk_vcn_flow_logs_stream" {
  name           = "splunk_vcn_flow_logs_stream"
  partitions     = 1
  stream_pool_id = oci_streaming_stream_pool.splunk_vcn_flow_logs_stream_pool.id
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
# Stream and StreamPool for loadbalancers
resource "oci_streaming_stream_pool" "splunk_lb_logs_connector_stream_pool" {
  compartment_id = var.compartment_ocid
  name           = "splunk_lb_logs_connector_stream_pool"
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_streaming_stream" "splunk_lb_logs_connector_stream" {
  name           = "splunk_lb_logs_connector_stream"
  partitions     = 1
  stream_pool_id = oci_streaming_stream_pool.splunk_lb_logs_connector_stream_pool.id
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

/*
resource "oci_streaming_stream_pool" "splunk_audit_events_stream_pool" {
  compartment_id = var.compartment_ocid
  name           = "splunk_audit_events_stream_pool"
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_streaming_stream" "splunk_audit_events_stream" {
  name           = "splunk_audit_events_stream"
  partitions     = 1
  stream_pool_id = oci_streaming_stream_pool.splunk_audit_events_stream_pool.id
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
*/