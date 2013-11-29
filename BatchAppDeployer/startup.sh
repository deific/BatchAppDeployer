#!/bin/sh
export JAVA_HOME=D:\softwares\jdks\Java\jdk1.6.0_07
export JAVA_DEBUG="-Xdebug -Xnoagent -Xrunjdwp:transport=21211,address=${DEBUG_PORT},server=y,suspend=n"
exec ${JAVA_HOME}/bin/java -server -Xms256m -Xmx512m %JAVA_DEBUG% -cp . -jar AppDeployTool.jar
