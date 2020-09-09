#!/bin/bash

if [$Force_fail_client_healthcheck == 'yes'] || [$Force_fail_client_healthcheck == 'Yes'] || [$Force_fail_client_healthcheck == 'YES'] || [$Force_fail_client_healthcheck == 'true']
then
    exit 2
fi

ip=$1
port=3000
hostname=${ip}:${port}

for (( ; ; ))
do
    sleep 1
    if [[ $(wget -S -T1 -t1 http://${hostname}/health-check 2>&1 | grep "HTTP/1" | awk '{print $2}') == "200" ]] ; then
        echo 'connected to' ${hostname}
        exit 0
    else
        echo 'cannot connect to' ${hostname}
    fi
done
exit 1