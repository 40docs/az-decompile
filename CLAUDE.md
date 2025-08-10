# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is the **az-decompile** repository - an Azure Bicep decompilation project that demonstrates ARM JSON to Bicep conversion for Fortinet FortiGate infrastructure templates. The project showcases systematic cleanup of common conversion issues found when migrating from ARM templates to modern Bicep syntax.

## Common Development Commands

### Validation and Linting
```bash
# Lint all markdown files
npm run lint

# Auto-fix markdown issues  
npm run lint:fix

# Validate Bicep templates
npm run validate:bicep

# Run all validations (lint + bicep)
npm run validate
```

### Azure Bicep Operations
```bash
# Initial decompilation from ARM JSON to Bicep
az bicep decompile --file azuredeploy.json

# Build/compile Bicep to ARM JSON
az bicep build --file final/azuredeploy.bicep

# Deploy Bicep template
az deployment group create \
  --resource-group <resource-group> \
  --template-file final/azuredeploy.bicep \
  --parameters final/azuredeploy.parameters.json
```

## Project Architecture

### Directory Structure
- **`base/`** - Raw decompilation output with original ARM JSON and initial Bicep conversion
- **`final/`** - Production-ready Bicep templates after systematic cleanup
- **`interventions.txt`** - Complete log of all decompilation issues and fixes applied

### Core Template Components
The FortiGate infrastructure template deploys:
- **Dual FortiGate HA Setup**: Two FortiGate instances (FGT-A, FGT-B) in availability sets
- **Multi-Architecture Support**: Both x64 and ARM64 instance types with conditional logic
- **Networking**: 4 subnets with multi-NIC configuration for external, internal, heartbeat, and management
- **Public IPs**: External and management access points
- **License Models**: BYOL, PAYG, and FortiFlex support

### Key Variables and Parameters
- **`fortiGateNamePrefix`** - Naming prefix for all resources (VMs get suffixes `-FGT-A` and `-FGT-B`)
- **`fortiGateInstanceArchitecture`** - Controls x64 vs ARM64 deployment path (`x64` | `arm64`)
- **`fortiGateImageSKU_x64/arm64`** - License model selection (BYOL vs PAYG variants)
- **`acceleratedNetworking`** - Boolean parameter for Azure accelerated networking

## Common Decompilation Issues and Fixes

### Variable Naming Conflicts
Original decompilation creates variables with `_var` suffixes due to naming conflicts:
```bicep
// ❌ Raw decompilation output
var vnetName_var = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)

// ✅ Cleaned up version  
var var_vnetName = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)
```

### String vs Boolean Type Issues
ARM templates often use string representations of booleans:
```bicep
// ❌ String boolean (ARM legacy)
param acceleratedNetworking string = 'true'
@allowed(['true', 'false'])

// ✅ Native boolean (modern Bicep)
param acceleratedNetworking bool = true
```

### Unnecessary Dependencies
Bicep can infer many dependencies automatically:
```bicep
// ❌ Explicit dependsOn (unnecessary)
resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  dependsOn: [
    virtualNetwork
  ]
}

// ✅ Implicit dependency (preferred)
resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  properties: {
    ipConfigurations: [{
      subnet: {
        id: virtualNetwork.properties.subnets[0].id  // Automatic dependency
      }
    }]
  }
}
```

### String Interpolation vs Concat
Replace legacy ARM concat() functions:
```bicep
// ❌ ARM concat function
var customData = concat(header, body, footer)

// ✅ Modern Bicep interpolation
var customData = '${header}${body}${footer}'
```

## Quality Standards

### Bicep Best Practices
- Use modern Bicep syntax and native types
- Leverage automatic dependency inference
- Use string interpolation over concat()
- Apply proper parameter validation with `@allowed()` decorators
- Include comprehensive `@description()` annotations

### Validation Requirements
- All templates must pass `az bicep build` without errors
- Markdown files must pass markdownlint-cli2 validation
- Parameter files must have valid placeholder values (avoid "TODO" entries in production)

## Deployment Notes

### Prerequisites
- Azure CLI with Bicep extension installed
- Active Azure subscription with appropriate permissions
- Resource group created for deployment target

### Architecture-Specific Considerations
- **x64 instances**: Standard VM sizes, mature ecosystem
- **ARM64 instances**: Limited VM sizes, newer architecture with different performance characteristics
- **Conditional logic**: Template uses `fortiGateInstanceArchitecture` parameter to select appropriate VM sizes and image SKUs

### Network Requirements
- **External subnet**: Public-facing interface for traffic ingress
- **Internal subnet**: Private network for protected resources  
- **Heartbeat subnet**: HA synchronization between FortiGate instances
- **Management subnet**: Administrative access and monitoring

## Important Coding Guidelines

### File Modification Patterns
- Always work on `final/` directory for production templates
- Keep `base/` directory as reference for original decompilation output
- Document all changes in `interventions.txt` for future reference

### Template Validation
- Test deployments in development environment before production use
- Validate parameter combinations (especially architecture + image SKU pairings)
- Ensure all template parameters have appropriate default values or are marked required

### Security Considerations
- Admin passwords are marked `@secure()` and should never be hardcoded
- Network Security Groups are configured for appropriate access control
- FortiGate instances require proper licensing (BYOL requires valid license files)