@echo off
 
::默认PID，无需修改
set "PID=999999"
::记录当前目录，无需修改
set "CURRENT_PATH=%cd%"
 
::指定java_home路径，不能起名JAVA_HOME，会覆盖环境变量
set "JAVA_HOME_CUSTOM=C:\Program Files\Java\jdk1.8.0_191"
::指定jre_home
set "JRE_HOME_CUSTOM=C:\Program Files\Java\jdk1.8.0_191\jre"
::指定maven_home，不能起名MAVEN_HOME，会覆盖环境变量
set "MAVEN_HOME_CUSTOM=C:\"Program Files\JetBrains\IntelliJ IDEA 2019.3.1"\plugins\maven\lib\maven3"
 
 
::指定程序工作路径
set "SERVICE_DIR=E:\springCloud"
::指定程序包名
set "JARNAME=ms-base-config-server-0.0.1-SNAPSHOT.jar"
::指定程序端口号
set "port=8750"
::指定程序启动日志名
set "LOG_FILE=eureka.log"
 
 

::流程控制
if "%1"=="start" (
  call:START
) else (
  if "%1"=="stop" (
    call:STOP
  ) else (
    if "%1"=="restart" (
	  call:RESTART
	) else (
	   if "%1"=="build" (
      	  call:BUILD
      	) else (
      	  call:DEFAULT
      	)
	)
  )
)

goto:eof



 
::启动jar包
:START
echo function "start" starting...
call:STOP
cd /d %SERVICE_DIR%
echo execute service
start /b  "%JRE_HOME_CUSTOM%\bin\java.exe -Xms128m -Xmx512m -jar" %SERVICE_DIR%\target\%JARNAME% > %SERVICE_DIR%\logs\%LOG_FILE%
cd /d %CURRENT_PATH%
echo == service start success
goto:eof
 
 
::停止java程序运行
:STOP
echo function "stop" starting...
call:findPid
call:shutdown
echo == service stop success
goto:eof
 
 
::重启jar包
:RESTART
echo function "restart" starting...
call:STOP
call:sleep2
call:START
echo == service restart success
goto:eof
 
 
::执行默认方法--重启jar包
:DEFAULT
echo Now choose default item : restart
call:STOP
call:sleep2
call:START
echo == service restart success
goto:eof
 
 
::找到端口对应程序的pid
:findPid
echo function "findPid" start.
for /f "tokens=5" %%i in ('netstat -aon ^| findstr %port%') do (
    set "PID=%%i"
)
if "%PID%"=="999999" ( echo pid not find, skip stop . ) else ( echo pid is %PID%. )
goto:eof
 
 
::杀死pid对应的程序
:shutdown
if not "%PID%"=="999999" ( taskkill /f /pid %PID% )
goto:eof
 
 
::延时5秒
:sleep5
ping 127.0.0.1 -n 5 >nul
goto:eof
 
 
::延时2秒
:sleep2
ping 127.0.0.1 -n 2 >nul
goto:eof