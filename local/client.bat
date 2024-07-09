@echo off
title Input Chat

:register
set /p "username= Enter a username: " 
echo %username% Joined the chatroom (%time%::%date%) >> userLogs.cdat

cls
start read.bat

:messageLoop
set /p "message=Enter Message: "
echo %username%: %message%>>messageLogs.cdat
cls
goto messageLoop
