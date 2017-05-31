#!/bin/bash

#content-type
CT="Content-Type:application/json"

#username and password
USER="admin"
PASSWD="nutanix/4u"

echo "What would you like to do?\n"
echo "1) Create a New Department"
echo "2) Create a New VM"
echo "3) View Usage Data"
echo "4) Modify Department Settings"
echo "5) Update Data Services IP"
read menu_num

if [ $menu_num -eq 1 ]
	then
	/Users/dan.ricks/Desktop/TechSummitLab/CreateNewDepartment.sh
fi

if [ $menu_num -eq 2 ]
	then
	/Users/dan.ricks/Desktop/TechSummitLab/CreateCentVM1.sh
fi

if [ $menu_num -eq 4 ]
	then
	/Users/dan.ricks/Desktop/TechSummitLab/ModDept1.sh
fi