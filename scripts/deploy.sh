#!/bin/bash

# Deploy script for Aurvix Smart CRM
# Usage: ./scripts/deploy.sh [target-org-alias] [--checkonly]

# Change to the project directory (parent of scripts folder)
cd "$(dirname "$0")/.."

# Set default org alias if not provided
TARGET_ORG=${1:-"aurvix-dev"}
CHECK_ONLY=${2:-""}

echo "🚀 Deploying Aurvix Smart CRM to org: $TARGET_ORG"

# Check if the org is authenticated
if ! sfdx force:org:list --json | grep -q "\"alias\":\"$TARGET_ORG\""; then
    echo "❌ Error: Org '$TARGET_ORG' is not authenticated."
    echo "Please authenticate first: sfdx force:auth:web:login --setalias $TARGET_ORG"
    exit 1
fi

# Build the deployment command
DEPLOY_CMD="sfdx force:source:deploy --sourcepath force-app/main/default --targetusername $TARGET_ORG"

# Add checkonly flag if specified
if [ "$CHECK_ONLY" = "--checkonly" ]; then
    DEPLOY_CMD="$DEPLOY_CMD --checkonly"
    echo "📋 Running validation deployment (check-only mode)"
else
    echo "📦 Deploying source code"
fi

# Execute the deployment
echo "Executing: $DEPLOY_CMD"
eval $DEPLOY_CMD

# Check the exit status
if [ $? -eq 0 ]; then
    if [ "$CHECK_ONLY" = "--checkonly" ]; then
        echo "✅ Validation successful! No deployment errors found."
    else
        echo "✅ Deployment successful!"
    fi
else
    echo "❌ Deployment failed. Please check the errors above."
    exit 1
fi 