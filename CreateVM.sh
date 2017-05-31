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
echo -n "Enter the name of your Windows VM:"
read vm_name
echo Creating a VM named $vm_name

curl --insecure -X POST \
$SERVICE_URL$RESOURCE_VM -u $USER:$PASSWD \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{  
   "description":"Tech Summit 2017",
   "guest_os":"Windows Server 2012 R2",
   "memory_mb":4096,
   "name":"'"$vm_name"'",
   "num_cores_per_ vcpu":2,
   "num_vcpus":1,
   "vm_disks":[  
      {  
         "disk_address":{  
            "device_bus":"ide",
            "device_index":0
         },
         "is_cdrom":true,
         "is_empty":false,
         "vm_disk_clone":{  
            "disk_address":{  
               "vmdisk_uuid":"450a39cb-9105-4daf-96a4-d9a66737738d"
            }
         }
      },
      {  
         "disk_address":{  
            "device_bus":"scsi",
            "device_index":0
         },
         "vm_disk_create":{  
            "storage_container_uuid":"0814ca14-8452-450b-a1dc-fd3a8502f10c",
            "size":10737418240
         }
      },
      {  
         "disk_address":{  
            "device_bus":"ide",
            "device_index":1
         },
         "is_ cdrom":true,
         "is_empty":false,
         "vm_disk_clone":{  
            "disk_address":{  
               "vmdisk_uuid":"ecb4b7c1-ddff-4d14-90c7-60ba098ed147"
            }
         }
      }
   ],
   " hypervisor_type":"ACROPOLIS",
   "affinity":null
}'
