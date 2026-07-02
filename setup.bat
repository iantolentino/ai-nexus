@echo off
REM AI Nexus - installer / updater (Windows cmd.exe).
REM
REM Run from your project's root directory: setup.bat
REM
REM - If _brain\ does not exist yet: installs it fresh.
REM - If _brain\ already exists: updates framework files only, never touches project data.
REM   See _brain\templates\update_rules.md for the exact split.
REM - Also drops root-level pointer files (CLAUDE.md, AGENTS.md, .cursorrules, .windsurfrules,
REM   .github\copilot-instructions.md) so any AI tool auto-loads instructions to read
REM   _brain\claude.md first - only where none already exists.

setlocal enabledelayedexpansion

set REPO=https://github.com/iantolentino/ai-nexus.git
set TARGET=_brain
set TMP_DIR=_ai_nexus_tmp_%RANDOM%

where git >nul 2>&1
if errorlevel 1 (
    echo git is required and was not found on PATH.
    exit /b 1
)

echo AI Nexus installer
echo Cloning framework...
git clone --depth 1 %REPO% "%TMP_DIR%" >nul 2>&1
if errorlevel 1 (
    echo Failed to clone repository. Check your network connection.
    exit /b 1
)

if exist "%TARGET%" (
    echo _brain already exists - updating framework files only ^(project data untouched^).

    for %%F in (claude.md aibrain.md INDEX.md) do (
        if exist "%TMP_DIR%\_brain\%%F" (
            copy /y "%TMP_DIR%\_brain\%%F" "%TARGET%\%%F" >nul
            echo   updated: %%F
        )
    )

    for %%D in (prompts governance interaction templates) do (
        if exist "%TMP_DIR%\_brain\%%D" (
            xcopy "%TMP_DIR%\_brain\%%D" "%TARGET%\%%D\" /E /I /H /Y >nul
            echo   updated: %%D\
        )
    )

    if exist "%TMP_DIR%\_brain\tasks\task_rules.md" (
        if not exist "%TARGET%\tasks" mkdir "%TARGET%\tasks"
        copy /y "%TMP_DIR%\_brain\tasks\task_rules.md" "%TARGET%\tasks\task_rules.md" >nul
        copy /y "%TMP_DIR%\_brain\tasks\task_templates.md" "%TARGET%\tasks\task_templates.md" >nul
        echo   updated: tasks\task_rules.md, tasks\task_templates.md
    )

    if exist "%TMP_DIR%\_brain\fixes\README.md" (
        if not exist "%TARGET%\fixes" mkdir "%TARGET%\fixes"
        copy /y "%TMP_DIR%\_brain\fixes\README.md" "%TARGET%\fixes\README.md" >nul
        copy /y "%TMP_DIR%\_brain\fixes\_template.md" "%TARGET%\fixes\_template.md" >nul
        echo   updated: fixes\README.md, fixes\_template.md
    )

    if exist "%TMP_DIR%\_brain\quick-ref\README.md" (
        if not exist "%TARGET%\quick-ref" mkdir "%TARGET%\quick-ref"
        copy /y "%TMP_DIR%\_brain\quick-ref\README.md" "%TARGET%\quick-ref\README.md" >nul
        echo   updated: quick-ref\README.md
    )
) else (
    echo Installing fresh _brain ...
    xcopy "%TMP_DIR%\_brain" "%TARGET%\" /E /I /H /Y >nul
)

echo Installing AI-tool entry points ^(only where none already exist^)...
call :install_entry "CLAUDE.md" "CLAUDE.md"
call :install_entry "AGENTS.md" "AGENTS.md"
call :install_entry ".cursorrules" ".cursorrules"
call :install_entry ".windsurfrules" ".windsurfrules"
if not exist ".github" mkdir ".github"
call :install_entry "copilot-instructions.md" ".github\copilot-instructions.md"

echo Cleaning up...
rmdir /s /q "%TMP_DIR%"

echo.
echo Done. _brain is ready.
echo Next: paste _brain\prompts\bootstrap_prompt.md into a new AI chat session to start.

exit /b 0

:install_entry
set SRC_NAME=%~1
set DEST_PATH=%~2
if exist "%DEST_PATH%" (
    echo   skipped %DEST_PATH% ^(already exists^) - add this line manually: "Read _brain/claude.md in full before doing anything else."
) else (
    copy /y "%TMP_DIR%\_brain\templates\entrypoints\%SRC_NAME%" "%DEST_PATH%" >nul
    echo   created: %DEST_PATH%
)
exit /b 0
