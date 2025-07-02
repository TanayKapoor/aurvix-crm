@echo off
REM Deploy script for Aurvix Smart CRM
REM Usage: scripts\deploy.bat [target-org-alias] [--checkonly]

REM Change to the project directory (parent of scripts folder)
cd /d "%~dp0.."

REM Set default org alias if not provided
set TARGET_ORG=%1
if "%TARGET_ORG%"=="" set TARGET_ORG=aurvix-dev

set CHECK_ONLY=%2

echo 🚀 Deploying Aurvix Smart CRM to org: %TARGET_ORG%

REM Check if the org is authenticated
sf org list | findstr /C:"%TARGET_ORG%" >nul
if errorlevel 1 (
    echo ❌ Error: Org '%TARGET_ORG%' is not authenticated.
    echo Please authenticate first: sf org login web --alias %TARGET_ORG%
    exit /b 1
)

REM Build the deployment command
set DEPLOY_CMD=sf project deploy start --source-dir force-app/main/default --target-org %TARGET_ORG%

REM Add dry-run flag if specified (equivalent to checkonly)
if "%CHECK_ONLY%"=="--checkonly" (
    set DEPLOY_CMD=%DEPLOY_CMD% --dry-run
    echo 📋 Running validation deployment (dry-run mode)
) else (
    echo 📦 Deploying source code
)

REM Execute the deployment
echo Executing: %DEPLOY_CMD%
%DEPLOY_CMD%

REM Check the exit status
if errorlevel 1 (
    echo ❌ Deployment failed. Please check the errors above.
    exit /b 1
) else (
    if "%CHECK_ONLY%"=="--checkonly" (
        echo ✅ Validation successful! No deployment errors found.
    ) else (
        echo ✅ Deployment successful!
    )
) 