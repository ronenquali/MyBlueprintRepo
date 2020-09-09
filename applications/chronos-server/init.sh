#!/bin/bash
export name=$SERVER_NAME
export version=$SERVER_VERSION
export reader_healthcheck_paths="/;/env"
# configure dsyslog to send to logz.io
curl -sL https://qsdevops.s3-eu-west-1.amazonaws.com/rsyslog_install.sh | /bin/bash -s chronos-server;

echo "init script did it's thing, good bye"
