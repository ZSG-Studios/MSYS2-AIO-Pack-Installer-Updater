@echo off
:MENU
REM --------------------------------------------------------------------------
REM This script runs under Windows CMD, calling MSYS2 bash to:
REM   1) Update MSYS2 repeatedly if needed (pacman updates) until no more updates.
REM   2) Run the msys2-arch-install.sh script to install the desired toolchains.
REM   3) Optionally performs a final update (as defined in the .sh script itself).
REM   4) If the system needs a restart due to pacman upgrading msys2-runtime,
REM      it will exit from the bash shell with an error code. This .cmd script
REM      re-runs the update if that happens.
REM --------------------------------------------------------------------------

setlocal

REM Adjust MSYS2_DIR if you installed MSYS2 somewhere else:
set "MSYS2_DIR=C:\msys64"

REM Construct the path to bash:
set "MSYS2_BASH=%MSYS2_DIR%\usr\bin\bash.exe"

if not exist "%MSYS2_BASH%" (
    echo MSYS2 bash not found at: "%MSYS2_BASH%"
    echo Please verify MSYS2_DIR is correct.
    pause
    exit /b 1
)

cls
echo ===================================
echo           MAIN MENU
echo ===================================
echo 1) Update Packages!
echo 2) Add Packages!
echo 3) Exit
echo.
set /p choice="Enter your choice [1-3]: "

REM Evaluate the choice and jump to the relevant label.
if %choice%==1 goto BEGIN_UPDATE
if %choice%==2 goto SEL_PACKAGES
if %choice%==3 goto EXIT
goto MENU

:BEGIN_UPDATE
    	echo Updating MSYS2 using pacman -Syu --noconfirm
    	"%MSYS2_BASH%" -lc "pacman -Syu --noconfirm"
    	if errorlevel 1 goto BEGIN_UPDATE
	REM If pacman or msys2-runtime is updated, the old bash can exit with code 1.
	REM This loop re-runs the update until no more forced restarts occur.
	REM Script completed.
	echo.
	echo Update has completed.
        pause
goto MENU

:SEL_PACKAGES
	REM Now run the user installation script:
	echo Starting msys2-arch-install.sh...
	"%MSYS2_BASH%" -lc "cd "/c/msys64/" && ./msys2-arch-install.sh"
	REM Script completed.
	echo.
	echo msys2-arch-install.sh has completed.
        pause
goto MENU

:EXIT
pause
endlocal
exit /b 0