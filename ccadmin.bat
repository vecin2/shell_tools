@echo off

setlocal

set CORE_HOME=%~dp0..
set ANT_HOME=%CORE_HOME%\lib\ant
set CCADMIN_HOSTNAME=%COMPUTERNAME%

if exist "%CORE_HOME%\config\project_env.bat" call "%CORE_HOME%\config\project_env.bat"
if exist "%HOMEDRIVE%%HOMEPATH%\.kana\ccadmin_env.bat" call "%HOMEDRIVE%%HOMEPATH%\.kana\ccadmin_env.bat"

if not "%JAVA_HOME%" == "" goto java_home_set
echo "Please setup the environment variable JAVA_HOME to point to a valid Java installation"
goto end

:java_home_set
set ANT_OPTS=-Xmx512m -XX:MaxMetaspaceSize=1024m -Dsvnkit.http.keepCredentials=false %ANT_OPTS%

if "%1" == "help" goto setup_help
set TARGET=run
goto setup_command

:setup_help
set TARGET=help
shift

:setup_command
set COMMAND=%1
set COMMAND_FILE=%CORE_HOME%\scripts\run-command.xml

shift

:process_args
if ""%1""=="""" goto run_command
set CMD_ARGS=%CMD_ARGS% %1
shift
goto process_args

if exist %CORE_HOME%\lib\ccadmin_antlib\AntLogger*.jar copy %CORE_HOME%\lib\ccadmin_antlib\AntLogger*.jar %CORE_HOME%\lib\antlib\AntLogger.jar

if exist %CORE_HOME%\lib\antlib\AntLogger.jar set CUSTOM_LOGGER=="-logger com.gtnet.ant.logger.ParallelLogger"

:run_command
%ANT_HOME%\bin\ant -lib %CORE_HOME%\lib\antlib %CUSTOMER_LOGGER% -f %COMMAND_FILE% "-Drun.command=%COMMAND%" -Drun.target=%TARGET% -Ddefault.core.home=%CORE_HOME% -Dccadmin.hostname=%CCADMIN_HOSTNAME% %CCADMIN_OPTS% %CMD_ARGS%

:end
endlocal
