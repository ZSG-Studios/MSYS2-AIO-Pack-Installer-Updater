# MSYS2-AIO-Pack-Installer-Updater
MSYS2 AIO Pack Installer / Updater with a few QOL options like environment types.

🚀 Installation & Usage

1️⃣ Save the scripts

Save update_and_run.sh in C:\msys64\.
Save msys2_update.cmd in C:\msys64\.
Ensure msys2_aio_installer.sh is inside C:\msys64\.

2️⃣ Run the Windows CMD script
Open Command Prompt (cmd.exe) and execute:
C:\msys64\msys2_update.cmd

This will: ✔ Update MSYS2 completely
✔ Restart MSYS2 if required
✔ Run msys2_aio_installer.sh after updating




🚀 How to Use the Script

Save the script as msys2_aio_installer.sh.

Make it executable:
chmod +x msys2_aio_installer.sh

Run the script:
./msys2_aio_installer.sh

Choose an installation option:
1: Install only Base Packages.
2: Install only Cross Toolchain Packages.
3: Install only MINGW64 Packages.
4: Install only ClangARM64 Packages.
5: Install only Clang64 Packages.
6: Install only UCRT64 Packages.
7: Install EVERYTHING.
0: Exit.

🔥 What This Script Does
✔ Categorizes and installs MSYS2 groups correctly
✔ Excludes mingw-w64-i686 packages
✔ Ensures updates before installing
✔ Provides an "Install All" option
✔ User-friendly and easy to expand
