@echo off
set REPO=https://github.com/iantolentino/ai-nexus.git
set TARGET=ai-nexus

echo Cloning full repository...
git clone %REPO% %TARGET%
cd %TARGET%

echo Cleaning up...

:: Keep only _brain folder
for /d %%D in (*) do (
    if /I not "%%D"=="_brain" rmdir /s /q "%%D"
)

for %%F in (*) do (
    if /I not "%%F"=="README.md" if /I not "%%F"=="yourfile.bat" del /f /q "%%F"
)

:: Flatten _brain into root
xcopy _brain\* . /E /I /H /Y >nul
rmdir /s /q _brain

echo Done. Only _brain content remains.

exit
