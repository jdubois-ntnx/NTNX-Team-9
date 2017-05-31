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
echo "Enter the name of your department: 1=HR 2=IT 3=DEV"
read dept_name
echo Creating VM

rand_num=$(((RANDOM%100)+1))

if [ $dept_name -eq 1 ] 
then 
net_uuid="de1c9349-51fe-4331-8bc2-6ac9b576a868"
disk_uuid="cbed3278-70d8-4f69-83a8-4bc8e192e275"
vm_name="HR-VM-$rand_num"

fi

if [ $dept_name -eq 2 ]
then 
net_uuid="63359e3e-5381-4b80-890a-8dd86d46bc6f"
disk_uuid="e3469627-a2e7-41bc-997d-fcb6f8345ac1"
vm_name="IT-VM-$rand_num"
fi

if [ $dept_name -eq 3 ]
then 
net_uuid="3712d159-be15-4907-9463-8420d32ed60b"
disk_uuid="d96b7e30-d8b2-43b5-abe7-6023b3b6f917"
vm_name="DEV-VM-$rand_num"
fi

curl --insecure -X POST \
  https://10.68.69.102:9440/PrismGateway/services/rest/v2.0/vms/ \
  -H 'authorization: Basic YWRtaW46bnV0YW5peC80dQ==' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 4166de49-58c3-5652-e933-992fba3046b0' \
  -d '{
   "description": "CentOS Deployment",
   "guest_os": "CentOS",
   "memory_mb": 2048,
   "name": "'"$vm_name"'",
   "num_cores_per_vcpu": 1,
   "num_vcpus": 1,
   "vm_disks": [
      {
         "disk_address": {
            "device_bus": "scsi",
            "device_index": 0
         },
         "is_cdrom": false,
         "is_empty": false,
         "vm_disk_clone": {
            "disk_address": {
               "vmdisk_uuid": "'"$disk_uuid"'",
               "size": 10737418240
            }
         }
      }
      
   ],
   
    "vm_nics": [
    {
      "network_uuid": "'"$net_uuid"'"
    }
  ],
   "hypervisor_type": "ACROPOLIS",
   "affinity": null
}'

