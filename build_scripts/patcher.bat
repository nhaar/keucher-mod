@REM shoutouts to NERS

@echo off
setlocal EnableDelayedExpansion

set "vbsFile=%TEMP%\keucher_patcher_select_folder.vbs"

> "%vbsFile%" (
    echo Set objShell = CreateObject^("Shell.Application"^)
    echo Set objFolder = objShell.BrowseForFolder^(0, "Select your DELTARUNE installation folder.", 0, 17^)
    echo If Not objFolder Is Nothing Then WScript.Echo objFolder.Self.Path
)

for /f "usebackq delims=" %%I in (`cscript //nologo "%vbsFile%"`) do (
    set "installDir=%%I"
)
del "%vbsFile%"

if not defined installDir (
    exit /b
)

set "confirmVBS=%TEMP%\keucher_patcher_confirm_patch.vbs"

> "%confirmVBS%" (
    echo res = MsgBox^("This will attempt to patch the files named ""data.win""^! Make sure your vanilla data files are named as such. The modded files will be saved as ""data_keucher.win"". Proceed?", vbYesNo+vbQuestion, "Confirm Patching"^)
    echo WScript.Echo res
)

for /f "usebackq delims=" %%A in (`cscript //nologo "%confirmVBS%"`) do (
    set "choice=%%A"
)
del "%confirmVBS%"

if not "%choice%"=="6" (
    exit /b
)

set "file=%installDir%\data.win"
for /f "skip=1 tokens=*" %%A in ('certutil -hashfile "%file%" MD5 ^| find /v "CertUtil"') do set "hash=%%A"

if not defined hash (
    echo ERROR: Missing "%file%"^^!
    echo Press any key to exit...
    pause >nul
    exit /b
)

if /i "%hash%" == "ED4568BAB864166BFD6322CEEB3FB544" (
    echo Patching DEMO v1.15...
    patch_files\flips.exe --apply patch_files\v1.15-demo.bps "%installDir%\data.win" "%installDir%\data_keucher.win"
    if errorlevel 1 (
        echo Press any key to exit...
        pause >nul
        exit /b
    )
) else if /i "%hash%" == "B5EF0EEC9554C491777D6C4E93E0DF76" (
    echo Patching Chapter Select v1.02...
    patch_files\flips.exe --apply patch_files\v1.02-chapter_select.bps "%installDir%\data.win" "%installDir%\data_keucher.win"
    if errorlevel 1 (
        echo Press any key to exit...
        pause >nul
        exit /b
    )

    CALL CheckChapters4

    for %%C in (1 2 3 4) do (
        echo Patching Chapter %%C v1.02...
        patch_files\flips.exe --apply patch_files\v1.02-chapter%%C.bps "%installDir%\chapter%%C_windows\data.win" "%installDir%\chapter%%C_windows\data_keucher.win"
        if errorlevel 1 (
            echo Press any key to exit...
            pause >nul
            exit /b
        )
    )
) else if /i "%hash%" == "DDEDBBD10FF129B49C64DBEFAA763C6A" (
    echo Patching Chapter Select for latest CH5 release...
    patch_files\flips.exe --apply patch_files\ch5_latest-chapter_select.bps "%installDir%\data.win" "%installDir%\data_keucher.win"
    if errorlevel 1 (
        echo Press any key to exit...
        pause >nul
        exit /b
    )

    CALL CheckChapters5

    for %%C in (1 2 3 4 5) do (
        echo Patching Chapter %%C for latest CH5 release...
        patch_files\flips.exe --apply patch_files\ch5_latest-chapter%%C.bps "%installDir%\chapter%%C_windows\data.win" "%installDir%\chapter%%C_windows\data_keucher.win"
        if errorlevel 1 (
            echo Press any key to exit...
            pause >nul
            exit /b
        )
    )
) else (
    echo MsgBox "Error! This data.win is not supported! If a new CH5 patch came out, please contact the mod managers to make a new patch", vbOKOnly+vbInformation, "Error" > %temp%\error.vbs
    cscript //nologo %temp%\error.vbs
    del %temp%\error.vbs
    exit /b
)

set "doneVBS=%TEMP%\keucher_patcher_done.vbs"

> "%doneVBS%" (
    echo msgBox "Keucher Mod applied^! All you have to do now is rename your vanilla Chapter Select data file to something else and rename the modded one to ""data.win"" to launch the mod.", vbOKOnly+vbInformation, "Patching Complete"
)

cscript //nologo "%doneVBS%"
del "%doneVBS%"

endlocal
exit /b

@REM functions

:CheckChapters4
    for %%C in (
        "%installDir%\chapter1_windows\data.win"
        "%installDir%\chapter2_windows\data.win"
        "%installDir%\chapter3_windows\data.win"
        "%installDir%\chapter4_windows\data.win"
    ) do (
        if not exist "%%~C" (
            echo ERROR: Missing "%%~fxC"^^!
            echo Press any key to exit...
            pause >nul
            exit /b
        )
    )

:CheckChapters5
    for %%C in (
        "%installDir%\chapter1_windows\data.win"
        "%installDir%\chapter2_windows\data.win"
        "%installDir%\chapter3_windows\data.win"
        "%installDir%\chapter4_windows\data.win"
        "%installDir%\chapter5_windows\data.win"
    ) do (
        if not exist "%%~C" (
            echo ERROR: Missing "%%~fxC"^^!
            echo Press any key to exit...
            pause >nul
            exit /b
        )
    )