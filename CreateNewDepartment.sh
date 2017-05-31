#!/bin/bash

#content-type
CT="Content-Type:application/json"

#username and password
USER="admin"
PASSWD="nutanix/4u"

#services
SERVICE_URL="https://10.68.69.102:9440/PrismGateway/services/rest/v2.0"
RESPONSE_CODE="%{http_code}\n"

#resource
RESOURCE_VM="/vms/"
RESOURCE_SC="/storage_containers/"
RESOURCE_IM="/images/"
echo "Enter the name of your department:"
read dept_name
echo Creating a Department Named $dept_name

curl --insecure -X POST \
  https://10.68.69.102:9440/PrismGateway/services/rest/v2.0/storage_containers/ \
  -H 'authorization: Basic YWRtaW46bnV0YW5peC80dQ==' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: fa692ef2-1830-7a80-bdde-46c9e0ed73dd' \
  -d '{
  "name": "dpt_'"$dept_name"'",
  "replication_factor": "1",
  "compression_enabled": "true"
  }'
  echo Container Created

vlan_tag=$(((RANDOM%1000)+1))
  
 
curl --insecure -X POST \
  https://10.68.69.102:9440/PrismGateway/services/rest/v2.0/networks/ \
  -H 'authorization: Basic YWRtaW46bnV0YW5peC80dQ==' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: ab82f84c-acd6-d5d6-7ee3-cb6abfaf639a' \
  -d '{
      "name": "dpt_net_'"$dept_name"'",
      "vlan_id": "'"$vlan_tag"'"
      }'
echo Network Created with vlan tag $vlan_tag

