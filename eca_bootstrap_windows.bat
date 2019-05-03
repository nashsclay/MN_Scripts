REM Editing this file may destroy your wallet or coins! Do NOT do it!
echo off
setlocal
:MENU
cls
SET LASTUPDATE= April 27, 2019
SET BOOTSTRAPFILE=https://github.com/Electra-project/Electra-Bootstrap/releases/download/v1.0/ElectraBootstrap.zip
SET PSSCRIPT=%SYSTEMDRIVE%\ElectraWalletBackup\tmpDlFile.ps1
SET PowerShellDir=%SYSTEMDRIVE%\Windows\System32\WindowsPowerShell\v1.0
ECHO.
ECHO ...............................................
ECHO ECA User Support Bootstrap Fix v1.0
ECHO Windows 7, 8, 8.1, 10 ONLY!!
ECHO PRESS 1 to do your bootstrap or press 2 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - ECA BOOTSTRAP
ECHO 2 - EXIT
ECHO.
SET /P M=Type 1 or 2 then press ENTER: 
IF %M%==1 GOTO BOOTSTRAP
IF %M%==2 GOTO EXIT

:BOOTSTRAP
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
set today=%Year%-%Month%-%Day%
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Checking for Electra folder...
IF EXIST %APPDATA%\Electra\ (
mkdir %SYSTEMDRIVE%\ElectraWalletBackup\
echo Copying wallet.dat to %SYSTEMDRIVE%\ElectraWalletBackup
copy %APPDATA%\Electra\wallet.dat %SYSTEMDRIVE%\ElectraWalletBackup\ /y
copy %APPDATA%\Electra\wallet.dat %SYSTEMDRIVE%\ElectraWalletBackup\%today%wallet.dat /y
echo.
echo wallet.dat successfully backedup!
echo.
echo Press any key to open up the backedup folder...
pause
explorer %SYSTEMDRIVE%\ElectraWalletBackup\
echo.
echo Now the script will continue to perform the bootstrap fix
echo.
pause
echo.
echo -=ECA User Spport Bootstrap Fix=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Wallets need to be closed. You need to have version 2.0 or greater! Follow the prompt to close it automatically.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
taskkill /F /IM  "electra-qt.exe" /T >nul 2>&1
echo.
echo Downloading the bootstrap... This may take some time as it is around 240MB
echo File will be automatically removed when script completes
echo.
echo %PSSCRIPT%
IF EXIST %PSSCRIPT% DEL /Q /F %PSSCRIPT%
ECHO [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls">>"%PSSCRIPT%"
ECHO Invoke-WebRequest "https://github.com/Electra-project/Electra-Bootstrap/releases/download/v1.0/ElectraBootstrap.zip" -OutFile "%SYSTEMDRIVE%\ElectraWalletBackup\ElectraBootstrap.zip">>"%PSSCRIPT%"
CD /D %PowerShellDir%
Powershell -ExecutionPolicy Bypass -Command "& %PSSCRIPT%"
echo.
echo Checking for Electra folder...
echo Protecting file wallet.dat...
echo.
attrib +r %APPDATA%\Electra\wallet.dat
echo Now deleting Electra wallet files except protected file...
echo.
del /S /Q %APPDATA%\Electra\*.*
rmdir /Q %APPDATA%\Electra\database
rmdir /Q %APPDATA%\Electra\txleveldb
rmdir /Q %APPDATA%\Electra\sporks
rmdir /Q %APPDATA%\Electra\zerocoin
rmdir /Q %APPDATA%\Electra\blocks
cls
echo.
echo Old Files Deleted
echo.
attrib -r %APPDATA%\Electra\wallet.dat
echo Unzipping files to %APPDATA%\Electra
PowerShell Expand-Archive -Path "%SYSTEMDRIVE%\ElectraWalletBackup\ElectraBootstrap.zip" -DestinationPath "%APPDATA%\Electra"
del /S /Q %SYSTEMDRIVE%\ElectraWalletBackup\ElectraBootstrap.zip
del /S /Q %SYSTEMDRIVE%\ElectraWalletBackup\tmpDlFile.ps1
echo Unlocking files wallet.dat, peers.dat and Electra.conf to be used for wallet...
echo.
echo Wallet data unlocked for safe use
echo.
echo Please run the Electra Wallet to ensure bootstrap successful.
echo.
) ELSE (
echo No Electra folder detected.
echo wallet.dat backup failed!
echo No Electra folder detected in default location. Contact User Support for manual fix.
echo Bootstrap failed! Your wallet program has been untouched.
echo Exiting...
pause
GOTO MENU
)
