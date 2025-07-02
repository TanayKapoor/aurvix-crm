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
sf org login web --alias aurvix-dev --instance-url https://login.salesforce.com

# For sandbox
sf org login web --alias aurvix-sandbox --instance-url https://test.salesforce.com
```

### 2. Set Default Org (Optional)

```bash
sf config set target-org=aurvix-dev
```

### 3. Retrieve Existing Metadata (if applicable)

```bash
# Retrieve all metadata from org
sf project retrieve start --manifest manifest/package.xml

# Or retrieve specific metadata types
sf project retrieve start --metadata CustomObject ApexClass Flow
```

### 4. Deploy Changes to Org

```bash
# Deploy all changes
sf project deploy start --source-dir force-app/main/default

# Deploy specific components
sf project deploy start --source-dir force-app/main/default/classes
```

## Common SFDX Commands

### Org Management
```bash
# List all authenticated orgs
sf org list

# Open org in browser
sf org open --target-org aurvix-dev

# Create scratch org
sf org create scratch --definition-file config/project-scratch-def.json --alias aurvix-scratch
```

### Metadata Operations
```bash
# Pull changes from org
sf project retrieve start

# Push changes to scratch org
sf project deploy start

# Check deployment status
sf project deploy report --job-id <deployment-id>

# Run Apex tests
sf apex run test --result-format human
```

### Data Management
```bash
# Import sample data
sf data import tree --plan data/sample-data-plan.json

# Export data
sf data export tree --query "SELECT Id, Name FROM Account" --output-dir data
```

### Development Workflow
```bash
# Create new Apex class
sf apex generate class --name MyClass --output-dir force-app/main/default/classes

# Create new Lightning Web Component
sf lightning generate component --name myComponent --type lwc --output-dir force-app/main/default/lwc

# Validate deployment without deploying
sf project deploy start --source-dir force-app/main/default --dry-run
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
3. Run validation: `sf project deploy start --dry-run --source-dir force-app/main/default`
4. Create a pull request with detailed description
5. Ensure all tests pass before merging

## Support

For questions or issues related to the Aurvix Smart CRM project, please contact the development team or create an issue in this repository.
