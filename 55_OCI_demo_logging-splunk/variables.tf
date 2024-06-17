## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

# Required by the OCI Provider
variable "compartment_ocid" {
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "Oracle Cloud Compute Compartment where the infra will be deployed"
}

variable "tenancy_ocid" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaawquag7eeulmm6e2yoykcvigene6piosc6rwgglznmt4d5iubifuq"
  description = "Oracle Cloud Identifier tenancy"
}

variable "user_ocid" {
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaakrlp2rwn3ouh45vplzlsqphkjo25i7dbodhl4wctcrzyt7sh4cta"
  description = "Oracle Cloud Identifier user"
}

variable "fingerprint" {
  type        = string
  default     = "66:df:ee:f4:c3:fe:84:90:ac:d6:50:65:ca:2e:d6:57"
  description = "Oracle Cloud Fingerprint for the key pair"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/oci-console-private.pem"
}

variable "region" {
  type        = string
  default     = "mx-queretaro-1"
  description = "Oracle Cloud region"
}
variable "availability_domain_name" {
  default = ""
}

variable "availability_domain_number" {
  default = 0
}

variable "use_existing_vcn" {
  default = false
}

variable "vcn_id" {
  default = ""
}

variable "lb_subnet_id" {
  default = ""
}

variable "compute_subnet_id" {
  default = ""
}

# Key used to SSH to OCI VMs
variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
}

variable "ssh_private_key" {
  #https://forums.oracle.com/ords/apexds/post/terraform-ssh-private-key-issue-9138
  type    = string
  default = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAleT74XsYzXyBgbQvo+WLvmkJPnGfFGurRMtl97Y5DIleDrq3
2Gh9APtDwsMMESG/ABcicVuMvQqtpfgdIxMYT3JFAuNsa991OH2/3w0vCIDvGNKW
5CxfT2WwQ7YFDXKfZoIXi4nOFu212E9UtVYRZLXtX+HKuIBf17AJ1PnI/tUAQ69B
VNpXqGnPOwYXiOshgf4u5UsMOhb6ZeKLU4VbqAvdrSLjlzTD0iwabCPooDaAPuD1
Icki4sf+AimAVGJpmLGV+Pqzd6kUZPmdiYqLHVVehJ3c3sgoSedEzcSVae0iHOv2
EvpP87EsfXf1tlua0g0QdVnhCjGvkO0bimMcfwIDAQABAoIBACXoo/UqGyM45k3l
wpiqQJXW3aIfvTI+arG62R51ROdRRGroOP+vqVGauk/i4UXh6Xq93xWZKDZVIYaU
gdXxidfp1987ohuEB5LSZrikDm2RoiZ+d+/b8vzTBGmTeqKkhwC3TPoaz3bIBpHe
ulckHcEBK7fwlELmIJcda9cjlvwvgkvPR5oGEt5osxGiE3I1zsWZc2kSgntYrGVF
FOisITbi+/cSVWGA9lCPW3DVkyAa7OtuVdxrosaP1YY+yhSDmdNFPLlEvRK5ezgx
/dJDph+VDgrPBGLsa13EOaqPTAxY2fJzb11Uos4BuU1VNMdYt6avUq8RqyZ4CmdV
G+MNfY0CgYEAxXYjf8YtjU05qhP0EI4rVjDL74sdB5kcXUIKbELoDrF7nivt2Cxn
b2R32VCVfgpI6xAUY30ptLYcfL2H3zHkYRKs0TboPSc80GVUW9q7FhDsgoXJHkJm
hEBW1IhmjznzeP1w1pfoghx6H/SZ+E7rYQlALz2J6vmu3Y6U5LrGsm0CgYEAwlTc
rQyBi4JTYF93lGKzXGW6PoKYCtMcxILhVO9Ac8jxP19gjB5deheCIkqEkg26yEs8
5h4nscqc8EfgthD5c802mnH+9vuUljQ/1YHHnNkFHGeoe5Qk75H9/Hbuo027fQGW
koOaZrWe7hdCHul9I1vxAjQPt2pwYWgFhBbwlxsCgYAwQ88rhTJPLoggxV3LyiRX
nffLJnLDD666MNFBYx07sjAoGk65nyjtNl6BFMxlkXf/VN/W7ZoLHNRbvSv/5z8O
ZzUsskIT6IpZ2drD1PQT0bEtuivNpKdQPjW7H1gKPD0B3tj86wae/vzu4Kfd5NRt
1IgGxAD5GWyfpSFJw0mcBQKBgQCCWpxgdAgdxcEZ30/+OCrqKs7Aiadlc3FTnBt8
drR8NmklQlwoAWJguI4xZF0C/7SwEE/8aHPl/exB/WUNm9tIw3oCJb+Kev2Tt96t
4E0+uBCGmj3ZD2mrTfnaNQkkf8rpMnyHMUIL7X57ZRyUUbkAU/cZrERymzJhFH7G
uQCPywKBgCdaNSIkoMOSQzBr0kXM80fClLlfHxm6SRWsGKMgWviupsJCtJsyszVz
kpHOZvefujuQBnKdEs2kASKPThx8ikU2/ys5ZgWlXLrfGAM4LsZGvHd2JWqqqnxa
tQ39pJuJV3uzz48bL+9M1MpnDL1PI0A7YMqQCwJnvXcACDTx8H1c
-----END RSA PRIVATE KEY-----
EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# Network variables
# ---------------------------------------------------------------------------------------------------------------------
variable "ad_number" {
  default     = 0
  description = "Which availability domain to deploy, zero based."
}
variable "numberOfNodes" {
  default = 2
}

variable "igw_display_name" {
  default = "internet-gateway"
}

variable "vcn01_cidr_block" {
  default = "194.168.0.0/16"
}

variable "vcn01_lb_subnet_cidr_block" {
  default = "194.168.1.0/24"
}

variable "vcn01_compute_subnet_cidr_block" {
  default = "194.168.2.0/24"
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "lb_listener_port" {
  default = 80
}

variable "lb_listener_backend_port" {
  default = 80
}

variable "InstanceShape" {
  default = "VM.Standard2.8"
}

variable "InstanceFlexShapeOCPUS" {
  default = 1
}

variable "InstanceFlexShapeMemory" {
  default = 1
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "9"
}

# --------------------------
# master instance variables
# --------------------------

variable "master_shape" {
  default = "VM.Standard2.8"
}

variable "master_disk_count" {
  default = 1
}

variable "master_disk_size" {
  default = 50
}

variable "password" {
  default = "admin123!"
}

variable "sites_string" {
  default = "site1,site2"
}

# --------------------------
# indexer instance variables
# --------------------------

variable "indexer_shape" {
  default = "VM.Standard2.4"
}

variable "indexer_disk_count" {
  default = 1
}

variable "indexer_disk_size" {
  default = 50
}

# ------------------------------
# search deployer instance variables
# ------------------------------

variable "search_deployer_shape" {
  default = "VM.Standard2.2"
}

variable "role_title" {
  default = "search_head_deployer"
}

# ------------------------------
# search head instance variables
# ------------------------------

variable "search_head_shape" {
  default = "VM.Standard2.2"
}

variable "search_head_count" {
  default = 2
}

variable "search_head_disk_count" {
  default = 1
}

variable "search_head_disk_size" {
  default = 50
}

variable "shc_pass" {
  default = "asdf4567"
}
variable "images" {
  type = map(string)
  default = {
    mx-queretaro-1 = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaamxqzcyqme44cjrfebyxqz6mcrlam4yjopyjgdhffc6xy7wxeysoa"
    sa-santiago-1  = "ocid1.image.oc1.sa-santiago-1.aaaaaaaahulxzohkmje5lshmebwly2z3v3xdumypcunqlhe3l3skb4d77rha"
    sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaqzkez5umgblxezzswl32yf7uqzeyrv63zpjmoi6e2vxyd2v3plaa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaj6pcmnh6y3hdi3ibyxhhflvp3mj2qad4nspojrnxc6pzgn2w3k5q"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaa2wadtmv6j6zboncfobau7fracahvweue6dqipmcd5yj6s54f3wpq"
  }
}
variable "bucket_name" {
  type    =string
  default ="audit-events"
}
variable "bucket_namespace" {
    type    =string
    default ="grxmw2a9myyj"
}
variable "bucket_access_type" {
  type    = string
  default = "NoPublicAccess"
}

variable "user-data" {
  default = <<EOF
#!/bin/bash -x
# echo '########## yum update all ###############'
yum update -y

echo '########## basic webserver ##############'
yum install -y httpd openssl wget mod_ssl
systemctl enable --now httpd.service
firewall-cmd --add-service=http --persistent
firewall-cmd --add-port=80/tcp --persistent
firewall-cmd --reload
echo '<html><head></head><body><pre><code>' > /var/www/html/index.html
echo '<b>' $(hostname) '</b>'  >> /var/www/html/index.html
echo '' >> /var/www/html/index.html
#cat /etc/os-release >> /var/www/html/index.html
sudo mkdir -p /var/www/html/img
sudo wget  https://docs.oracle.com/en-us/iaas/Content/Resources/Images/loadBalancer3adRegional.png -O /var/www/html/img/loadbalancer-reg.png
sudo chown -R apache:apache  /var/www/html/
echo '<img src="img/loadbalancer-reg.png" alt="Load Balancer Regional">'>> /var/www/html/index.html
echo '</code></pre></body></html>' >> /var/www/html/index.html
EOF
}

#Windows specifications
variable "instance_shape" {
  description = "Instance size"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "instance_shape_cpu" {
  description = "Instance vCPUs"
  type        = string
  default     = "1"
}

variable "instance_shape_mem" {
  description = "Instance Memory in GB"
  type        = string
  default     = "6"
}