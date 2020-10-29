#!/bin/bash

if [[ -z "${APPLICATION_HISTORYSERVER_DEBUG}" ]]; then
  echo "Debugging is disabled for JobHistory Server"
else
  export HADOOP_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9998"
fi
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR historyserver
