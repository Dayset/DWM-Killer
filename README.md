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
