@echo off
title DWM Revive¸
tasklist /FI "IMAGENAME eq dwm.exe" 2>NUL | find /I /N "dwm.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo It's running.
    Press any key to ignore echo and execute the DWM shutdown procedure.
    pause>nul
    echo.
)

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
    pause
    echo ATTENTION! if you run this script UAC will be "broken". To accept UAC requests from now on, you need to press 2x tab and than enter.
    echo If 2x Tab + Enter UAC accept is not working, try 3x Tab and Enter
    echo Be sure to read and understand readme.txt BEFORE executing DWM-Killer for the first time.
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
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: Revert Fullscreenoptimization to default settings
REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V __COMPAT_LAYER
pushd
DEL "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Disable-Fullscreenoptimization-Globally.bat"
popd

echo.
echo UWP/Immersive Repairing components...
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: success) else echo   StartMenuExperienceHost.exe: fail

move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe.bak C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe>nul
if not errorlevel 1 (echo   SearchHost.exe: success) else echo   SearchHost.exe: fail

move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe.bak C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe>nul
if not errorlevel 1 (echo   TextInputHost.exe: success) else echo   TextInputHost.exe: fail

move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: success) else echo   ShellExperienceHost.exe: fail

move C:\Windows\System32\ApplicationFrameHost.exe.bak C:\Windows\System32\ApplicationFrameHost.exe>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: success) else echo   ApplicationFrameHost.exe: fail

move C:\Windows\ImmersiveControlPanel\SystemSettings.exe.bak C:\Windows\ImmersiveControlPanel\SystemSettings.exe>nul
if not errorlevel 1 (echo   SystemSettings.exe: success) else echo   SystemSettings.exe: fail

echo.
<nul set /p =UWP Enabling app background running... 
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /f>nul && reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /f>nul
if not errorlevel 1 (echo success) else echo fail

echo.
echo Disabling classic UI elements...

:reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /f>nul
:if not errorlevel 1 (echo   Volume control window: Success) else echo   Volume control window: Fail

:reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /f>nul
:if not errorlevel 1 (echo   Battery information window: Success) else echo   Battery information window: Fail

:reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /f>nul
:if not errorlevel 1 (echo   Date and Time Window: Success) else echo   Date and Time Window: Fail

:reg delete "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /f>nul
:if not errorlevel 1 (echo   Balloon notification window: Success) else echo   Balloon notification window: Fail

:reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /f>nul
:if not errorlevel 1 (echo   Alt+Tab: Success) else echo   Alt+Tab: Fail

move C:\Windows\System32\Windows.UI.Logon.dll.bak C:\Windows\System32\Windows.UI.Logon.dll>nul
if not errorlevel 1 (echo   Console Login: Success) else echo   Console Login: Fail

echo.
<nul set /p =dwminit.dll Activating... 
move C:\Windows\System32\dwminit.dll.bak C:\Windows\System32\dwminit.dll>nul
if not errorlevel 1 (echo success) else echo fail

:echo.
:<nul set /p =Activating visual themes... 
:move C:\Windows\Resources\Themes\aero\aero.msstyles.bak C:\Windows\Resources\Themes\aero\aero.msstyles>nul
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
