set CATALINA_HOME=%cd%\disttest
DEL /q/s %CATALINA_HOME%\logs\*.*
DEL /q/s %CATALINA_HOME%\temp\*.*
DEL /q/s %CATALINA_HOME%\work\*.*
call %CATALINA_HOME%\bin\catalina.bat jpda run
