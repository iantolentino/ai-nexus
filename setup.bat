@echo off
setlocal

set REPO=https://github.com/iantolentino/ai-nexus.git
set TARGET=_brain

echo Removing old folder if it exists...
rmdir /s /q "%TARGET%" 2>nul

echo Cloning repository into final folder name...
git clone %REPO% "%TARGET%"

cd "%TARGET%"

echo Cleaning everything except _brain folder...

for /d %%D in (*) do (
    if /I not "%%D"=="_brain" rmdir /s /q "%%D"
)

for %%F in (*) do (
    if /I not "%%F"=="README.md" del /f /q "%%F"
)

echo Flattening _brain...
xcopy "_brain\*" "." /E /I /H /Y >nul
rmdir /s /q "_brain"

cd ..

echo Done. Final folder is already named: _brain

exit
