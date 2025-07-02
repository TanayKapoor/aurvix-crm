# Aurvix Smart CRM

Aurvix is an intelligent Customer Relationship Management system built on the Salesforce platform. This project leverages advanced AI capabilities to provide smart insights, automated workflows, and enhanced customer engagement tools.

## Project Purpose

This Salesforce DX project contains the custom metadata, components, and configurations for the Aurvix Smart CRM system, including:

- Custom objects and fields for enhanced customer data management
- Intelligent flows and automation for streamlined processes
- Custom Apex classes and triggers for business logic
- Lightning Web Components for modern user interfaces
- Reports and dashboards for data-driven insights
- Permission sets for role-based access control

## Prerequisites

- Salesforce CLI (SFDX) installed
- Git installed
- Visual Studio Code with Salesforce extensions (recommended)
- Access to a Salesforce Developer Edition org or sandbox

## Setup Instructions

### 1. Authenticate to Your Salesforce Org

```bash
# For Developer Edition or production org
sfdx force:auth:web:login --setalias aurvix-dev --instanceurl https://login.salesforce.com

# For sandbox
sfdx force:auth:web:login --setalias aurvix-sandbox --instanceurl https://test.salesforce.com
```

### 2. Set Default Org (Optional)

```bash
sfdx force:config:set defaultusername=aurvix-dev
```

### 3. Retrieve Existing Metadata (if applicable)

```bash
# Retrieve all metadata from org
sfdx force:source:retrieve --manifest manifest/package.xml

# Or retrieve specific metadata types
sfdx force:source:retrieve --metadata CustomObject,ApexClass,Flow
```

### 4. Deploy Changes to Org

```bash
# Deploy all changes
sfdx force:source:deploy --sourcepath force-app/main/default

# Deploy specific components
sfdx force:source:deploy --sourcepath force-app/main/default/classes
```

## Common SFDX Commands

### Org Management
```bash
# List all authenticated orgs
sfdx force:org:list

# Open org in browser
sfdx force:org:open --targetusername aurvix-dev

# Create scratch org
sfdx force:org:create --definitionfile config/project-scratch-def.json --setalias aurvix-scratch
```

### Metadata Operations
```bash
# Pull changes from org
sfdx force:source:pull

# Push changes to scratch org
sfdx force:source:push

# Check deployment status
sfdx force:source:deploy:report --jobid <deployment-id>

# Run Apex tests
sfdx force:apex:test:run --resultformat human
```

### Data Management
```bash
# Import sample data
sfdx force:data:tree:import --plan data/sample-data-plan.json

# Export data
sfdx force:data:tree:export --query "SELECT Id, Name FROM Account" --outputdir data
```

### Development Workflow
```bash
# Create new Apex class
sfdx force:apex:class:create --classname MyClass --outputdir force-app/main/default/classes

# Create new Lightning Web Component
sfdx force:lightning:component:create --componentname myComponent --type lwc --outputdir force-app/main/default/lwc

# Validate deployment without deploying
sfdx force:source:deploy --sourcepath force-app/main/default --checkonly
```

## Project Structure

```
aurvix-crm/
├── force-app/main/default/
│   ├── classes/          # Apex classes
│   ├── triggers/         # Apex triggers  
│   ├── objects/          # Custom objects and fields
│   ├── flows/           # Process Builder and Flow definitions
│   ├── lwc/             # Lightning Web Components
│   ├── aura/            # Aura Components
│   ├── permissionsets/  # Permission sets
│   ├── layouts/         # Page layouts
│   ├── reports/         # Reports
│   ├── dashboards/      # Dashboards
│   └── staticresources/ # Static resources
├── scripts/             # Deployment and utility scripts
├── config/              # Scratch org definitions
└── manifest/            # Package.xml files
```

## Scripts

Use the helper scripts in the `scripts/` folder for common operations:

```bash
# Deploy to org
./scripts/deploy.sh aurvix-dev

# Retrieve from org  
./scripts/retrieve.sh aurvix-dev

# Run tests
./scripts/run-tests.sh aurvix-dev
```

## Contributing

1. Create a feature branch from `main`
2. Make your changes and test thoroughly
3. Run validation: `sfdx force:source:deploy --checkonly --sourcepath force-app/main/default`
4. Create a pull request with detailed description
5. Ensure all tests pass before merging

## Support

For questions or issues related to the Aurvix Smart CRM project, please contact the development team or create an issue in this repository.
