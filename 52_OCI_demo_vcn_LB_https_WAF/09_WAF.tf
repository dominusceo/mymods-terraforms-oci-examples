resource "oci_waf_web_app_firewall_policy" "demo52" {
  compartment_id = var.compartment_ocid
  display_name   = "demo52"

  actions {
    name = "block_access_from_usa"
    type = "RETURN_HTTP_RESPONSE"
    body {
      text = "<H1 style=\"text-align: center;\"><br>Access blocked by OCI WAF !<br>Access is not authorized from your country.</H1>"
      type = "STATIC_TEXT"
    }
    code = "401"
    headers {
    #https://docs.oracle.com/en-us/iaas/Content/WAF/Reference/httpheaders.htm
      name  = "X-Country-Code"
      value = "US"
    }
  }

  actions {
    name = "allow_access"
    type = "ALLOW"
    code = "200"
  }

  actions {
    name = "ForbbidenAction"
    type = "RETURN_HTTP_RESPONSE"
    code = "403"
  }
 request_access_control {
   #Required
   default_action_name = "block_access_from_usa"
   #Optional
   rules {
     #Required
     type        = "ACCESS_CONTROL"
     name        = "AllowSourcesbyCountryMX"
     action_name = "allow_access"
     condition   = "i_contains(connection.source.geo.countryCode, 'MX')"
     #Optional
     condition_language = "JMESPATH"
   }
 }

#   response_access_control {
#     #Optional
#     rules {
#       #Required
#       type        = "ACCESS_CONTROL"
#       name        = "responseAccessRule"
#       action_name = "return401Response"
#       condition   = "i_contains(keys(http.response.headers), 'Header1')"
#       #Optional
#       condition_language = "JMESPATH"
#     }
#   }

  request_protection {
    #Optional
    #body_inspection_size_limit_exceeded_action_name = "RETURN_HTTP_RESPONSE"
    body_inspection_size_limit_in_bytes             = 8192
    rules {
      #Required
      type                       = "PROTECTION"
      name                       = "requestProtectionRule"
      action_name                = "ForbbidenAction"
      is_body_inspection_enabled = true
      protection_capabilities {
        #Required
        key     = "9300000"
        version = 1
        #Optional
        collaborative_action_threshold = 4
        collaborative_weights {
          key    = "9301000"
          weight = 2
        }
        collaborative_weights {
          key    = "9301100"
          weight = 2
        }
        collaborative_weights {
          key    = "9301200"
          weight = 2
        }
        collaborative_weights {
          key    = "9301300"
          weight = 2
        }
        exclusions {
          args            = ["argName1", "argName2"]
          request_cookies = ["cookieName1", "cookieName2"]
        }
      }
    }
  }
  request_rate_limiting {
    #Optional
    rules {
      #Required
      type        = "REQUEST_RATE_LIMITING"
      name        = "requestRateLimitingRule"
      action_name = "ForbbidenAction"
      configurations {
        #Required
        period_in_seconds = 100
        requests_limit    = 10
        #Optional
        action_duration_in_seconds = 10
      }
      #Optional
      condition          = "i_contains(keys(http.request.headers), 'Header1')"
      condition_language = "JMESPATH"
    }
    #system_tags = var.web_app_firewall_policy_system_tags
  }
}

# associate the WAF policy to the OCI load balancer
resource "oci_waf_web_app_firewall" "demo52" {
  compartment_id             = var.compartment_ocid
  display_name               = "demo52"
  backend_type               = "LOAD_BALANCER"
  load_balancer_id           = oci_load_balancer_load_balancer.demo52-lb.id
  web_app_firewall_policy_id = oci_waf_web_app_firewall_policy.demo52.id
}