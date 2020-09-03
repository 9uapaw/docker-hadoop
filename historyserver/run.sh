#!/bin/bash

export HADOOP_OPTS=""
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR historyserver &
export HADOOP_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9999"
$HADOOP_HOME/bin/mapred --config $HADOOP_CONF_DIR historyserver
