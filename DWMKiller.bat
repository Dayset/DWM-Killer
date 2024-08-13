@echo off
cd /d "%~dp0"
title DWM Killer­

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo ATTENTION! if you run this script UAC will be "broken".
    echo To accept UAC requests from now on, you need to press 2x tab and than enter.
    echo Be sure to read and understand readme.txt BEFORE executing DWM-Killer for the first time.
    pause
    echo.
    echo Requesting administrator privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%cd%"
    cd /d "%~dp0"
:--------------------------------------
:: Disable Fullscreenoptimization globally
:: https://docs.microsoft.com/de-de/windows/deployment/planning/compatibility-fixes-for-windows-8-windows-7-and-windows-vista

pushd
copy "Disable-Fullscreenoptimization-Globally.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
popd


echo.
echo UWP/Immersive Terminating process...
taskkill -im ApplicationFrameHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: Terminated) else echo   ApplicationFrameHost.exe: Not running

taskkill -im TextInputHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   TextInputHost.exe: Terminated) else echo   TextInputHost.exe: Not running

taskkill -im SystemSettings.exe -f>nul 2>nul
if not errorlevel 1 (echo   SystemSettings.exe: Terminated) else echo   SystemSettings.exe: Not running

taskkill -im ShellExperienceHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: Terminated) else echo   ShellExperienceHost.exe: Not running

taskkill -im Winstore.App.exe -f>nul 2>nul
if not errorlevel 1 (echo   Winstore.App.exe: Terminated) else echo   Winstore.App.exe: Not running

taskkill -im StartMenuExperienceHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: Terminated) else echo   StartMenuExperienceHost.exe: Not running

taskkill -im SearchHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   SearchHost.exe: Terminated) else echo   SearchHost.exe: Not running

taskkill -im GameBar.exe -f>nul 2>nul
if not errorlevel 1 (echo   GameBar.exe: Terminated) else echo   GameBar.exe: Not running

echo.
echo UWP/Immersive Working to prevent component relaunch...

takeown /a /f C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
icacls C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: success) else echo   StartMenuExperienceHost.exe: fail

takeown /a /f C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe>nul
icacls C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe.bak>nul
if not errorlevel 1 (echo   SearchHost.exe: success) else echo   SearchHost.exe: fail

takeown /a /f C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe>nul
icacls C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe.bak>nul
if not errorlevel 1 (echo   TextInputHost.exe: success) else echo   TextInputHost.exe: fail

takeown /a /f C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
icacls C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: success) else echo   ShellExperienceHost.exe: fail

takeown /a /f C:\Windows\System32\ApplicationFrameHost.exe>nul
icacls C:\Windows\System32\ApplicationFrameHost.exe /grant Administrators:F>nul
move C:\Windows\System32\ApplicationFrameHost.exe C:\Windows\System32\ApplicationFrameHost.exe.bak>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: success) else echo   ApplicationFrameHost.exe: fail

takeown /a /f C:\Windows\ImmersiveControlPanel\SystemSettings.exe>nul
icacls C:\Windows\ImmersiveControlPanel\SystemSettings.exe /grant Administrators:F>nul
move C:\Windows\ImmersiveControlPanel\SystemSettings.exe C:\Windows\ImmersiveControlPanel\SystemSettings.exe.bak>nul
if not errorlevel 1 (echo   SystemSettings.exe: success) else echo   SystemSettings.exe: fail

echo.
<nul set /p Disabling app background execution... 
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f>nul && reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /t REG_DWORD /d 4 /f>nul
if not errorlevel 1 (echo success) else echo Fail

echo.
echo Enabling classic UI elements...
:reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /t REG_DWORD /d 0 /f>nul
:if not errorlevel 1 (echo   Volume control window: Success) else echo   Volume control window: Fail

:reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /t REG_DWORD /d 1 /f>nul
:if not errorlevel 1 (echo   Battery information window: Success) else echo   Battery information window: Fail

:reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /t REG_DWORD /d 1 /f>nul
:if not errorlevel 1 (echo   Date and Time Window (requires StartIsBack++ 2.9 or higher^): Success) else echo   Date and Time Window (requires StartIsBack++ 2.9 or higher^): Fail

reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /t REG_DWORD /d 1 /f>nul
if not errorlevel 1 (echo   Balloon notification window: Success) else echo   Balloon notification window: Fail

:reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /t REG_DWORD /d 1 /f>nul
:if not errorlevel 1 (echo   Alt+Tab: Success) else echo   Alt+Tab: Fail

takeown /a /f C:\Windows\System32\Windows.UI.Logon.dll>nul
icacls C:\Windows\System32\Windows.UI.Logon.dll /grant Administrators:F>nul
move C:\Windows\System32\Windows.UI.Logon.dll C:\Windows\System32\Windows.UI.Logon.dll.bak>nul
if not errorlevel 1 (echo   Console Login: Success) else echo   Console Login: Fail

echo.
<nul set /p =dwminit.dll Disabling... 
takeown /a /f C:\Windows\System32\dwminit.dll>nul
icacls C:\Windows\System32\dwminit.dll /grant Administrators:F>nul
move C:\Windows\System32\dwminit.dll C:\Windows\System32\dwminit.dll.bak>nul
if not errorlevel 1 (echo success) else echo fail

:<nul set /p =Disabling visual themes... 
:takeown /a /f C:\Windows\Resources\Themes\aero\aero.msstyles>nul
:icacls C:\Windows\Resources\Themes\aero\aero.msstyles /grant Administrators:F>nul
:move C:\Windows\Resources\Themes\aero\aero.msstyles C:\Windows\Resources\Themes\aero\aero.msstyles.bak>nul
:if not errorlevel 1 (echo success) else echo fail

echo.
echo complete!

echo.
choice /m "Sign out now?"
if %errorlevel% == 1 (
    logoff
    exit
) else (
    echo Press any key to close this window.
    timeout 20 >nul
)
