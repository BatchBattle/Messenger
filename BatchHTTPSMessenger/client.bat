@echo off
title Input Chat

:getServerURL
set /p "server_url=Enter the server URL: "


:getServerPort
set /p "server_port=Enter the server port: "

SET SERVER_URL=http://%server_url%:%server_port%

cls

:register
set /p "username=Enter a username: "
curl -X POST -H "Content-Type: application/json" -d "{\"username\": \"%username%\"}" %SERVER_URL%/login
echo.

cls

:getMaxMessages
set /p "maxMessages=Enter MAX messages (MAX 50): "
SET /A maxMessages
echo.

cls

start getMessages.bat

:messageLoop
set /p "message=Enter Message: "
curl -X POST -H "Content-Type: application/json" -d "{\"username\": \"%username%\", \"message\": \"%message%\"}" %SERVER_URL%/send_message
echo.
cls
goto messageLoop
