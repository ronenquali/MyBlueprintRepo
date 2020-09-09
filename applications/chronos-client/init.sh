#!/bin/bash

# configure dsyslog to send to logz.io
curl -sL https://qsdevops.s3-eu-west-1.amazonaws.com/rsyslog_install.sh | /bin/bash -s chronos-client;

echo "init script did it's thing, good bye"
