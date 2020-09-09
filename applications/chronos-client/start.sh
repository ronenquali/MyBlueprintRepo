#!/bin/bash

cd $ARTIFACTS_PATH
python3 client.py chronos-server.$DOMAIN_NAME  > /dev/null &