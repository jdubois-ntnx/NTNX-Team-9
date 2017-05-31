#!/bin/bash

#content-type
CT="Content-Type:application/json"

#user and password credentials
USER="admin"
PASSWD="nutanix/4u"

#services
SERVICE_URL="https://10.68.69.102:9440/PrismGateway/services/rest/v2.0"
RESPONSE_CODE="%{http_code}\n"

#resource
RESOURCE_VM="/vms/"
RESOURCE_SC="/storage_containers/"
RESOURCE_IM="/images/"



#List the Containers/Departments'
VALUE=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC?search_string=DPT" | jq -r .entities[].name)
echo "Departments:"
echo $VALUE

echo "Please enter the department that you wish to modify:"
read MODDEPT

echo "Current department container configuration:"
CFG=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC?search_string=$MODDEPT" | jq -r .entities[].compression_enabled)
echo "Compression:" $CFG


CTRUUID=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC?search_string=$MODDEPT" | jq -r .entities[].storage_container_uuid)

echo "Enter True to enable compression, or False to disable."
read BOOLENABLE


SETRESULT=$(curl --insecure -X PUT -H $CT -u $USER:$PASSWD -d "{ \"storage_container_uuid\": \"$CTRUUID\",\"name\": \"$MODDEPT\",\"compression_enabled\":\"$BOOLENABLE\",\"compression_delay_in_secs\":0 }" "https://10.68.69.102:9440/PrismGateway/services/rest/v2.0/storage_containers/")

echo $SETRESULT

