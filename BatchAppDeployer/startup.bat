@echo off
@TITLE=AppDeployToolV1.0
set JAVA_HOME=D:\softwares\jdks\Java\jdk1.6.0_07
set JAVA_DEBUG=-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=21211,server=y,suspend=n 
%JAVA_HOME%\bin\java -server -Xms256m -Xmx512m %JAVA_DEBUG% -cp . -jar AppDeployTool.jar
pause
