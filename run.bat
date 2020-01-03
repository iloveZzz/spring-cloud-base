@echo off
 
::其他bat工作路径
set "OTHER_BAT_WORK_SPACE=E:\springCloud"
::记录当前目录，无需修改
set "CURRENT_ROOT_PATH=%cd%"
::启动命令（start|stop|restart|其他默认重启）
set "PARAM1=start"
::指定maven_home，不能起名MAVEN_HOME，会覆盖环境变量
set "MAVEN_HOME_CUSTOM=C:\"Program Files\JetBrains\IntelliJ IDEA 2019.3.1"\plugins\maven\lib\maven3"
 
 
::流程控制
if "%1"=="start" (
  set "PARAM1=%1"
  call:START
) else (
  if "%1"=="stop" ( 
    set "PARAM1=%1"
    call:START
  ) else ( 
    if "%1"=="restart" (
	  set "PARAM1=%1"
	  call:START
	) else ( 
	  if "%1"=="build" (
	    call:BUILD
	  ) else (
	    set "PARAM1=restart"
	    call:START
	  )
	)
  )
)
goto:eof
::项目主流程开始

::编译打包
:BUILD
echo function "BUILD" starting...
cd /d %OTHER_BAT_WORK_SPACE%
call %MAVEN_HOME_CUSTOM%\bin\mvn clean install -Dmaven.test.skip=true
echo == service BUILD success
goto:eof



:START
echo %OTHER_BAT_WORK_SPACE%\ms-base-eureka-server\run.bat %PARAM1%
call %OTHER_BAT_WORK_SPACE%\ms-base-eureka-server\run.bat %PARAM1%
echo %OTHER_BAT_WORK_SPACE%\ms-base-config-server\run.bat %PARAM1%
call %OTHER_BAT_WORK_SPACE%\ms-base-config-server\run.bat %PARAM1%
goto:eof
