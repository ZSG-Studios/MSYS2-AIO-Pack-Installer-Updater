@echo off
SET MSYS2_PATH=C:\msys64\msys2.exe
SET MSYSTEM=MINGW64
SET CHERE_INVOKING=1
SET MSYS2_PATH_TYPE=inherit

echo Running MSYS2 Update...
start "" "%MSYS2_PATH%" /bin/bash -lc "/c/msys64/update_and_run.sh"
