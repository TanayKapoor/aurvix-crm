#!/bin/bash

# Test runner script for Aurvix Smart CRM
# Usage: ./scripts/run-tests.sh [target-org-alias] [--coverage]

# Set default org alias if not provided
TARGET_ORG=${1:-"aurvix-dev"}
COVERAGE_FLAG=${2:-""}

echo "🧪 Running Apex tests in org: $TARGET_ORG"

# Check if the org is authenticated
if ! sfdx force:org:list --json | grep -q "\"alias\":\"$TARGET_ORG\""; then
    echo "❌ Error: Org '$TARGET_ORG' is not authenticated."
    echo "Please authenticate first: sfdx force:auth:web:login --setalias $TARGET_ORG"
    exit 1
fi

# Build the test command
TEST_CMD="sfdx force:apex:test:run --targetusername $TARGET_ORG --resultformat human --wait 10"

# Add code coverage if specified
if [ "$COVERAGE_FLAG" = "--coverage" ]; then
    TEST_CMD="$TEST_CMD --codecoverage"
    echo "📊 Running tests with code coverage analysis"
else
    echo "🏃 Running all Apex tests"
fi

# Execute the tests
echo "Executing: $TEST_CMD"
eval $TEST_CMD

# Check the exit status
if [ $? -eq 0 ]; then
    echo "✅ All tests passed!"
    
    if [ "$COVERAGE_FLAG" = "--coverage" ]; then
        echo ""
        echo "📈 Code Coverage Summary:"
        sfdx force:apex:test:report --targetusername $TARGET_ORG --codecoverage --resultformat human
    fi
else
    echo "❌ Some tests failed. Please review the results above."
    exit 1
fi

echo ""
echo "💡 Tip: Use 'sfdx force:apex:test:report --targetusername $TARGET_ORG' to view detailed test results." 