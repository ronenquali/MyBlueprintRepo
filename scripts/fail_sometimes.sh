#!/bin/bash

# Get the value from the URL
value=$(curl -s https://keyvalue.immanuel.co/api/KeyVal/GetValue/bcjnc2li/destroy)

# Check if value is 'fail'
if [ "$value" = "fail" ]; then
    exit -1
else
    exit 0
fi
