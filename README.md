# Azure Bicep Decompilation Project

[![Bicep](https://img.shields.io/badge/Bicep-Latest-blue)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
[![Azure CLI](https://img.shields.io/badge/Azure_CLI-Latest-orange)](https://docs.microsoft.com/en-us/cli/azure/)
[![FortiGate](https://img.shields.io/badge/FortiGate-HA_Deployment-red)](https://github.com/fortinet/azure-templates)

This project demonstrates **ARM JSON to Bicep conversion** for Fortinet FortiGate infrastructure templates. It showcases the complete decompilation workflow, including systematic cleanup of common conversion issues found when migrating from ARM templates to modern Bicep syntax.

## 📋 Table of Contents

- [🎯 Project Overview](#-project-overview)
- [📁 Directory Structure](#-directory-structure)
- [🚀 Quick Start](#-quick-start)
- [🔄 Decompilation Workflow](#-decompilation-workflow)
- [🛠️ Common Fixes Applied](#️-common-fixes-applied)
- [🏗️ Infrastructure Details](#️-infrastructure-details)
- [🤝 Contributing](#-contributing)

## 🎯 Project Overview

**Source**: [Fortinet's official Azure templates](https://github.com/fortinet/azure-templates)  
**Purpose**: Demonstrate ARM-to-Bicep conversion with real-world infrastructure  
**Infrastructure**: Dual FortiGate HA setup with multi-architecture support

### Key Learning Outcomes

- Learn systematic ARM-to-Bicep conversion patterns
- Understand common decompilation issues and their fixes
- See practical application of Bicep best practices
- Experience FortiGate HA deployment on Azure

## 📁 Directory Structure

```text
├── base/                          # Raw decompilation output
│   ├── azuredeploy.bicep         # Original az bicep decompile output
│   ├── azuredeploy.json          # Source ARM template
│   └── azuredeploy.parameters.json
├── final/                         # Cleaned Bicep templates
│   ├── azuredeploy.bicep         # Production-ready Bicep
│   ├── azuredeploy.json          # Reference ARM template
│   └── azuredeploy.parameters.json
├── interventions.txt              # Complete fix log
├── .github/
│   └── copilot-instructions.md   # AI agent guidance
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) with Bicep extension
- Active Azure subscription
- Appropriate permissions to create resources

### Deploy the Infrastructure

1. **Clone and navigate to the repository:**

   ```bash
   git clone <repository-url>
   cd az-decompile
   ```

2. **Create a Resource Group:**

   ```bash
   az group create --name <your-resource-group> --location <azure-region>
   ```

3. **Deploy the Bicep template:**

   **Option A: With parameter prompts**

   ```bash
   az deployment group create \
     --resource-group <your-resource-group> \
     --template-file final/azuredeploy.bicep
   ```

   **Option B: With parameters file**

   ```bash
   # First, update azuredeploy.parameters.json with your values
   az deployment group create \
     --resource-group <your-resource-group> \
     --template-file final/azuredeploy.bicep \
     --parameters final/azuredeploy.parameters.json
   ```

## 🔄 Decompilation Workflow

This project follows a systematic approach to ARM-to-Bicep conversion:

### Step 1: Initial Decompilation

```bash
az bicep decompile --file azuredeploy.json
```

This creates the `base/` directory with raw decompilation output and numerous linting warnings.

### Step 2: Error Analysis

Review `interventions.txt` for a complete log of all decompilation issues:

- Variable naming conflicts (`_var` suffixes)
- String interpolation opportunities
- Boolean type mismatches
- Unnecessary resource dependencies

### Step 3: Systematic Cleanup

Apply fixes systematically across the template:

1. **Variable naming**: Remove `_var` suffixes
2. **String operations**: Replace `concat()` with interpolation
3. **Type corrections**: Convert string booleans to native types
4. **Dependencies**: Remove unnecessary `dependsOn` entries

### Step 4: Validation

Test deployment to ensure the cleaned template works correctly.

## 🛠️ Common Fixes Applied

### Variable Naming Cleanup

```bicep
// ❌ BAD (decompiled output)
var vnetName_var = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)

// ✅ GOOD (cleaned up)
var var_vnetName = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)
```

### String Interpolation

```bicep
// ❌ BAD (ARM legacy)
var customData = concat(header, body, footer)

// ✅ GOOD (modern Bicep)
var customData = '${header}${body}${footer}'
```

### Boolean Type Correction

```bicep
// ❌ BAD (string booleans)
param acceleratedNetworking string = 'true'
@allowed(['true', 'false'])

// ✅ GOOD (native boolean)
param acceleratedNetworking bool = true
@allowed([true, false])
```

### Dependency Optimization

```bicep
// ❌ BAD (unnecessary explicit dependency)
resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  dependsOn: [
    virtualNetwork  // Bicep can infer this from resource references
  ]
}

// ✅ GOOD (implicit dependency)
resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  properties: {
    ipConfigurations: [{
      subnet: {
        id: virtualNetwork.properties.subnets[0].id  // Implicit dependency
      }
    }]
  }
}
```

## 🏗️ Infrastructure Details

### FortiGate High Availability Setup

- **Virtual Machines**: 2x FortiGate instances (FGT-A, FGT-B)
- **Architecture Support**: Both x64 and ARM64 instances
- **Networking**: 4 subnets with multi-NIC configuration
- **High Availability**: Availability sets for redundancy
- **Management**: Public IPs for external and management access

### License Models Supported

- **BYOL**: Bring Your Own License
- **PAYG**: Pay As You Go (2023 SKUs)
- **FortiFlex**: Flexible licensing model

### Multi-Architecture Support

The template includes conditional logic for:

- VM sizing (x64 vs ARM64 instance types)
- Image SKU selection
- Performance optimizations per architecture

## 🧹 Linting & Quality

This project follows strict markdown and code quality standards:

- **Markdownlint compliance**: All markdown files pass linting rules (verified with `markdownlint-cli2`)
- **Bicep best practices**: Modern syntax and patterns
- **Conventional commits**: Structured commit messages
- **AI agent friendly**: Comprehensive documentation for automation

### Quality Checks

Run the following commands to validate the project:

```bash
# Check all markdown files
npx markdownlint-cli2 "**/*.md"

# Or use the provided script
./scripts/lint-markdown.sh

# Validate Bicep templates
az bicep build --file final/azuredeploy.bicep
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Follow the established patterns in `final/` directory
4. Update documentation as needed
5. Ensure all linting passes (`npx markdownlint-cli2 "**/*.md"`)
6. Create a Pull Request

### Development Tools

- Use VS Code with recommended extensions (see `.vscode/extensions.json`)
- Follow the commit message format in `.vscode/settings.json`
- Reference `.github/copilot-instructions.md` for AI assistance

## 📚 Additional Resources

- [Azure Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Fortinet Azure Templates](https://github.com/fortinet/azure-templates)
- [ARM to Bicep Decompilation Guide](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/decompile)
- [Bicep Best Practices](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices)

---

**Note**: Remember to update TODO placeholders in `azuredeploy.parameters.json` before deployment.
