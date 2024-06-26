#######################################################
##################### Disable firewalld ###############
#######################################################
systemctl stop firewalld
systemctl disable firewalld

# admin password
password=$(echo $json | jq -r $CONFIG_LOCATION.password)
sites_string=$(echo $json | jq -r $CONFIG_LOCATION.sites_string)
file="splunk-9.0.4-de405f4a7979-linux-2.6-x86_64.rpm" 
version="9.0.4"
url="https://download.splunk.com/products/splunk/releases/$version/linux/$file"
wget -O $file $url
chmod 744 $file
mkdir -p /opt/splunk
rpm -i $file

# copy over basic conf files
cat << EOF > /opt/splunk/etc/system/local/ui-tour.conf
[search-tour]
viewed = 1
EOF

# copy over master-apps conf files
cat << EOF > /opt/splunk/etc/master-apps/_cluster/local/indexes.conf
[_introspection]
repFactor = auto
EOF

# template other conf files
cat << EOF > /opt/splunk/etc/system/local/server.conf
[diskUsage]
minFreeSpace = 1000

[general]
site = site1

[clustering]
mode = master
multisite = true
replication_factor = 2
search_factor = 2
site_search_factor = origin:1,total:2
site_replication_factor = origin:1,total:2
pass4SymmKey = democluster
cluster_label = democluster
available_sites = $sites_string

[indexer_discovery]
pass4SymmKey = democluster
EOF

cat << EOF > /opt/splunk/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = $password
EOF

cat << EOF > /opt/splunk/etc/system/local/inputs.conf
[default]
host = cluster_master
EOF

cat << EOF > /opt/splunk/etc/system/local/outputs.conf
[indexer_discovery:indexer_discovery]
pass4SymmKey = democluster
master_uri = https://$public_ip:8089

[tcpout:indexers]
indexerDiscovery = indexer_discovery

[tcpout]
defaultGroup = indexers
EOF

cat << EOF > /opt/splunk/etc/system/local/health.conf 
[health_reporter]
aggregate_ingestion_latency_health = 0

[feature:ingestion_latency]
alert.disabled = 1
disabled = 1
EOF

echo "Start splunk"
/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt
