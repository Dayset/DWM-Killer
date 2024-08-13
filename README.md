# DWM-Killer
DWM-Killer is without suspicious executables and has a better readme in English.
Credits: https://github.com/Ingan121/DWMKiller


⚠️ Before executing this script, it is highly recommended to create a backup or restore point of your system.
Additionally, but not necessary: TEST DWMKiller and DWMRevive scripts on a Virtual Machine matching your system 1 to 1 to be sure that it is safe to use.


## !Important!

⚠️ Critical Information: Disabling DWM will cause the UAC interface to become non-functional (“soft brick”). The UAC prompt will appear blank, but you can still interact with it by pressing the “Tab” key twice (sometimes it's thrice) followed by the “Enter” key to accept the UAC request. Blank CMD window potentialy can wait for "Any key.." like "Y" for example.


## Potential Impact of Disabling DWM: Disabling the Desktop Window Manager (DWM) using this script can significantly affect various system functionalities, including but not limited to:

User Account Control (UAC)
System Stability
Performance Issues
Visual Effects
Ribbon UI
Start Menu
“Open With” functionality
Universal Windows Platform (UWP) applications
..and much more ☠️


## Let’s break down the batch script usage step by step:


```
@echo off
cd /d "%~dp0"
title DWM Killer
```
Turns off command echoing, so commands are not displayed as they are executed.
Changes the current directory to the directory where the script is located.
Sets the command prompt window title


```
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
    echo ATTENTION! if you run this script UAC will be "broken". To accept UAC requests from now on, you need to press 2x tab and than enter.
    echo If 2x Tab + Enter UAC accept is not working, try 3x Tab and Enter
    echo Be sure to read and understand readme.txt BEFORE executing DWM-Killer for the first time.
    pause
    echo.
    echo Requesting administrator privileges...
    goto UACPrompt
) else ( goto gotAdmin )
```
Checks if the script has administrative privileges by attempting to access system file Windows\SysWOW64\cacls.exe
CACLS is a command-line tool you can use to assign, display, or modify ACLs (access control lists) to files or folders.
If the script does not have admin rights (errorlevel not equal to 0), it displays a message and prompts the user to read the readme.txt file, then attempts to gain admin rights.

```
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
```
Creates a temporary VBScript (getadmin.vbs) to request admin rights and re-runs the batch script with elevated privileges.
If admin rights are acquired, it changes the directory to the script’s location.

```
:--------------------------------------
:: Disable Fullscreenoptimization globally
:: https://docs.microsoft.com/de-de/windows/deployment/planning/compatibility-fixes-for-windows-8-windows-7-and-windows-vista

pushd
copy "Disable-Fullscreenoptimization-Globally.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
popd
```
pushd: Saves the current directory and changes to the directory specified in the next command.
Copies the batch file Disable-Fullscreenoptimization-Globally.bat to the Startup folder, ensuring it runs automatically when the user logs in.
popd: Restores the previous directory saved by pushd
Turns off command echoing, so commands are not displayed as they are executed.
Enables delayed variable expansion, allowing the use of !variable! syntax to access variables within loops and conditional statements.
Runs Batch file as Admin
Stores all passed parameters in the params variable.
Changes the current directory to the directory where the script is located.
Checks if the script has admin rights by querying the system drive. If not, it creates a temporary VBScript to request admin rights and re-runs the batch script with elevated privileges.
Sets the __COMPAT_LAYER environment variable with multiple compatibility flags to disable fullscreen optimization and other visual effects globally.
Closing the script

```
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
```
Kills various processes related to UWP/Immersive applications and checks if the process was successfully terminated.

```
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
```
Takes ownership of specific system files, grants admin permissions, and renames them by adding a .bak extension.

```
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
```
Modifies registry settings to disable background access applications.
Takes ownership of specific system files, grants admin permissions, and renames them by adding a .bak extension.
Activates windows elements to maintain system stability

```
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
```
Displays a completion message and prompts the user to sign out. If the user chooses to sign out, the script logs off the user; otherwise, it waits for 20 seconds before closing the window.


# DWMRevive does basically the same but ib reverse order. Same style description would be overkill.
# If you don't understang what is going on here, just don't execute the script. Peace!
