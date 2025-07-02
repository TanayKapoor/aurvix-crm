@echo off
REM Test runner script for Aurvix Smart CRM
REM Usage: scripts\run-tests.bat [target-org-alias] [--coverage]

REM Set default org alias if not provided
set TARGET_ORG=%1
if "%TARGET_ORG%"=="" set TARGET_ORG=aurvix-dev

set COVERAGE_FLAG=%2

echo 🧪 Running Apex tests in org: %TARGET_ORG%

REM Check if the org is authenticated
sfdx force:org:list --json | findstr /C:"\"alias\":\"%TARGET_ORG%\"" >nul
if errorlevel 1 (
    echo ❌ Error: Org '%TARGET_ORG%' is not authenticated.
    echo Please authenticate first: sfdx force:auth:web:login --setalias %TARGET_ORG%
    exit /b 1
)

REM Build the test command
set TEST_CMD=sfdx force:apex:test:run --targetusername %TARGET_ORG% --resultformat human --wait 10

REM Add code coverage if specified
if "%COVERAGE_FLAG%"=="--coverage" (
    set TEST_CMD=%TEST_CMD% --codecoverage
    echo 📊 Running tests with code coverage analysis
) else (
    echo 🏃 Running all Apex tests
)

REM Execute the tests
echo Executing: %TEST_CMD%
%TEST_CMD%

REM Check the exit status
if errorlevel 1 (
    echo ❌ Some tests failed. Please review the results above.
    exit /b 1
) else (
    echo ✅ All tests passed!
    
    if "%COVERAGE_FLAG%"=="--coverage" (
        echo.
        echo 📈 Code Coverage Summary:
        sfdx force:apex:test:report --targetusername %TARGET_ORG% --codecoverage --resultformat human
    )
)

echo.
echo 💡 Tip: Use 'sfdx force:apex:test:report --targetusername %TARGET_ORG%' to view detailed test results. 