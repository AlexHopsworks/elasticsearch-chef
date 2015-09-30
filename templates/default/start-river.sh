#!/bin/sh

# SQL here is found in: Elastic_Rivers_Parent_Optimized.sql.erb

if [ "$#" -ne 1 ] ; then
  echo "usage: <prog> river-name.json"
  exit 1
fi

river=$1


if [ "${JDBC_IMPORTER_HOME}" = "" ] ; then
 export JDBC_IMPORTER_HOME=<%= @install_path %>
fi


bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
rivers=$JDBC_IMPORTER_HOME/rivers
river_dir="$(dirname $river)" 
river_pid=#{river#$river_dir}.pid

nohup java -cp "${lib}/*" -Dlog4j.configurationFile=${bin}/log4j2.xml org.xbib.tools.Runner org.xbib.tools.JDBCImporter $river &
echo $! > $rivers/$river_pid
