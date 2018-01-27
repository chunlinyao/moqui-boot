#!/bin/sh
pushd moqui
java -server -Xmx4096m -XX:-OmitStackTraceInFastThrow -Duser.timezone=Asia/Shanghai -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8091 -Dmoqui.conf=conf/MoquiDevConf.xml -Dmoqui.runtime=runtime -jar moqui.war "$@"
popd