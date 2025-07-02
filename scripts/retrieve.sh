#!/bin/bash

# Retrieve script for Aurvix Smart CRM
# Usage: ./scripts/retrieve.sh [source-org-alias] [metadata-types]

# Change to the project directory (parent of scripts folder)
cd "$(dirname "$0")/.."

# Set default org alias if not provided
SOURCE_ORG=${1:-"aurvix-dev"}
METADATA_TYPES=${2:-""}

echo "📥 Retrieving metadata from org: $SOURCE_ORG"

# Check if the org is authenticated
if ! sfdx force:org:list --json | grep -q "\"alias\":\"$SOURCE_ORG\""; then
    echo "❌ Error: Org '$SOURCE_ORG' is not authenticated."
    echo "Please authenticate first: sfdx force:auth:web:login --setalias $SOURCE_ORG"
    exit 1
fi

# Build the retrieve command
if [ -n "$METADATA_TYPES" ]; then
    RETRIEVE_CMD="sfdx force:source:retrieve --metadata $METADATA_TYPES --targetusername $SOURCE_ORG"
    echo "📋 Retrieving specific metadata types: $METADATA_TYPES"
else
    # Check if manifest exists
    if [ -f "manifest/package.xml" ]; then
        RETRIEVE_CMD="sfdx force:source:retrieve --manifest manifest/package.xml --targetusername $SOURCE_ORG"
        echo "📋 Retrieving metadata using manifest/package.xml"
    else
        # Retrieve common metadata types
        RETRIEVE_CMD="sfdx force:source:retrieve --metadata CustomObject,CustomField,ApexClass,ApexTrigger,Flow,PermissionSet,Layout,Report,Dashboard,LightningComponentBundle --targetusername $SOURCE_ORG"
        echo "📋 Retrieving common metadata types"
    fi
fi

# Execute the retrieve
echo "Executing: $RETRIEVE_CMD"
eval $RETRIEVE_CMD

# Check the exit status
if [ $? -eq 0 ]; then
    echo "✅ Metadata retrieval successful!"
    echo "💡 Review the changes and commit them to version control."
else
    echo "❌ Metadata retrieval failed. Please check the errors above."
    exit 1
fi 