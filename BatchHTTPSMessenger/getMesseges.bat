@echo off

set SERVER_URL=%SERVER_URL%

:readLogs

title Messages Logs
curl -s %SERVER_URL%/get_logs > logs

echo. > userLogs
echo. > messageLogs

for /f "tokens=*" %%A in ('powershell -Command "(Get-Content logs | ConvertFrom-Json).userlogs | Select-Object -Last 3"') do (
    echo %%A >> userLogs
)

for /f "tokens=*" %%B in ('powershell -Command "(Get-Content logs | ConvertFrom-Json).messages | Select-Object -Last %maxMessages%"') do (
    echo %%B >> messageLogs
)

cls

type userLogs
type messageLogs

timeout 2 > nul
goto readLogs
