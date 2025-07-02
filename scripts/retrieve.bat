@echo off
REM Retrieve script for Aurvix Smart CRM
REM Usage: scripts\retrieve.bat [source-org-alias] [metadata-types]

REM Set default org alias if not provided
set SOURCE_ORG=%1
if "%SOURCE_ORG%"=="" set SOURCE_ORG=aurvix-dev

set METADATA_TYPES=%2

echo 📥 Retrieving metadata from org: %SOURCE_ORG%

REM Check if the org is authenticated
sfdx force:org:list --json | findstr /C:"\"alias\":\"%SOURCE_ORG%\"" >nul
if errorlevel 1 (
    echo ❌ Error: Org '%SOURCE_ORG%' is not authenticated.
    echo Please authenticate first: sfdx force:auth:web:login --setalias %SOURCE_ORG%
    exit /b 1
)

REM Build the retrieve command
if not "%METADATA_TYPES%"=="" (
    set RETRIEVE_CMD=sfdx force:source:retrieve --metadata %METADATA_TYPES% --targetusername %SOURCE_ORG%
    echo 📋 Retrieving specific metadata types: %METADATA_TYPES%
) else (
    REM Check if manifest exists
    if exist "manifest\package.xml" (
        set RETRIEVE_CMD=sfdx force:source:retrieve --manifest manifest\package.xml --targetusername %SOURCE_ORG%
        echo 📋 Retrieving metadata using manifest\package.xml
    ) else (
        REM Retrieve common metadata types
        set RETRIEVE_CMD=sfdx force:source:retrieve --metadata CustomObject,CustomField,ApexClass,ApexTrigger,Flow,PermissionSet,Layout,Report,Dashboard,LightningComponentBundle --targetusername %SOURCE_ORG%
        echo 📋 Retrieving common metadata types
    )
)

REM Execute the retrieve
echo Executing: %RETRIEVE_CMD%
%RETRIEVE_CMD%

REM Check the exit status
if errorlevel 1 (
    echo ❌ Metadata retrieval failed. Please check the errors above.
    exit /b 1
) else (
    echo ✅ Metadata retrieval successful!
    echo 💡 Review the changes and commit them to version control.
) 