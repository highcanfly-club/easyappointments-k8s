#!/bin/bash
#########################################################################
# © Ronan LE MEILLAT 2023
# released under the GPLv3 terms
#########################################################################
echo "this is for development only with tilt.dev"
 kubectl delete namespace easyappointments
 kubectl create namespace easyappointments
 tilt up