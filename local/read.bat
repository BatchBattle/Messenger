@echo off 

:readMessages

title Messages List
type userLogs.cdat
type messageLogs.cdat
timeout /t 1

cls
goto readMessages
