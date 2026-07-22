@REM shoutouts to NERS

@echo off
setlocal EnableDelayedExpansion

set "vbsFile=%TEMP%\sw_practice_patcher_select_folder.vbs"

> "%vbsFile%" (
    echo Set objShell = CreateObject^("Shell.Application"^)
    echo Set objFolder = objShell.BrowseForFolder^(0, "Select your DELTARUNE installation folder from your Nintendo Switch SD card.", 0, 17^)
    echo If Not objFolder Is Nothing Then WScript.Echo objFolder.Self.Path
)

for /f "usebackq delims=" %%I in (`cscript //nologo "%vbsFile%"`) do (
    set "installDir=%%I"
)
del "%vbsFile%"

if not defined installDir (
    exit /b
)

set "confirmVBS=%TEMP%\sw_practice_patcher_confirm_patch.vbs"

> "%confirmVBS%" (
    echo res = MsgBox^("This will attempt to patch the files named ""game.win""^! Make sure your vanilla game files are named as such. The modded files will be saved as ""game_practice.win"". Proceed?", vbYesNo+vbQuestion, "Confirm Patching"^)
    echo WScript.Echo res
)

for /f "usebackq delims=" %%A in (`cscript //nologo "%confirmVBS%"`) do (
    set "choice=%%A"
)
del "%confirmVBS%"

if not "%choice%"=="6" (
    exit /b
)

for %%C in (
    "%installDir%\game.win"
    "%installDir%\chapter1_switch\game.win"
    "%installDir%\chapter2_switch\game.win"
    "%installDir%\chapter3_switch\game.win"
    "%installDir%\chapter4_switch\game.win"
) do (
    if not exist "%%~C" (
        echo ERROR: Missing "%%~fxC"^^!
        echo Press any key to exit...
        pause >nul
        exit /b
    )
)

set "file=%installDir%\game.win"
for /f "skip=1 tokens=*" %%A in ('certutil -hashfile "%file%" MD5 ^| find /v "CertUtil"') do set "hash=%%A"

if not defined hash (
    echo ERROR: Missing "%file%"^^!
    echo Press any key to exit...
    pause >nul
    exit /b
)

if /i NOT "%hash%" == "DADDB29D5977AC53429F9227342A892E" (
    echo MsgBox "Error! This game.win is not supported", vbOKOnly+vbInformation, "Error" > %temp%\error.vbs
    cscript //nologo %temp%\error.vbs
    del %temp%\error.vbs
    exit /b
)

echo Patching Chapter Select v1.08...
patch_files\flips.exe --apply patch_files\v1.08-switch-chapter_select.bps "%installDir%\game.win" "%installDir%\game_practice.win"
if errorlevel 1 (
    echo Press any key to exit...
    pause >nul
    exit /b
)

for %%C in (1 2 3 4 5) do (
    echo Patching Chapter %%C v1.08...
    patch_files\flips.exe --apply patch_files\v1.08-switch-chapter%%C.bps "%installDir%\chapter%%C_switch\game.win" "%installDir%\chapter%%C_switch\game_practice.win"
    if errorlevel 1 (
        echo Press any key to exit...
        pause >nul
        exit /b
    )
)

set "doneVBS=%TEMP%\sw_practice_patcher_done.vbs"

> "%doneVBS%" (
    echo msgBox "FLB Practice Mod applied^! All you have to do now is rename your vanilla Chapter Select game file to something else and rename the modded one to ""game.win"" to launch the mod.", vbOKOnly+vbInformation, "Patching Complete"
)

cscript //nologo "%doneVBS%"
del "%doneVBS%"

endlocal
exit /b
