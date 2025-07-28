# Copilot Instructions for Azure Bicep Decompilation Project

## Project Overview

This project demonstrates **ARM JSON to Bicep conversion** for Fortinet FortiGate infrastructure templates, sourced from [Fortinet's official Azure templates](https://github.com/fortinet/azure-templates). The codebase shows the complete decompilation workflow including systematic cleanup of common conversion issues.

## Directory Structure & Workflow

- **`base/`** - Raw `az bicep decompile` output with linting errors documented in `interventions.txt`
- **`final/`** - Cleaned Bicep templates after manual interventions
- **`interventions.txt`** - Complete error/warning log from decompilation process

**Core Infrastructure**: Dual FortiGate HA setup with 2 VMs, 4 subnets, multi-NIC configuration, and public IPs for external/management access.

## Critical Decompilation Patterns

When working with ARM-to-Bicep conversions, apply these specific fixes found in this project:

### 1. Variable Naming Cleanup

```bicep
// BAD (decompiled output)
var vnetName_var = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)

// GOOD (cleaned up)
var var_vnetName = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)
```

### 2. String Interpolation over concat()

```bicep
// BAD (ARM legacy)
var fgaCustomDataCombined = concat(customDataHeader, fgaCustomDataBody, customDataFooter)

// GOOD (modern Bicep)
var fgaCustomDataCombined = '${customDataHeader}${fgaCustomDataBody}${customDataFooter}'
```

### 3. Boolean Type Correction

```bicep
// BAD (string booleans from ARM)
param acceleratedNetworking string = 'true'
@allowed(['true', 'false'])

// GOOD (native bool)
param acceleratedNetworking bool = true
@allowed([true, false])
```

### 4. Remove Unnecessary dependsOn

Look for and remove `dependsOn` entries that Bicep can infer automatically from resource references.

## Development Workflow

1. **Decompile**: `az bicep decompile --file azuredeploy.json` (creates `base/` content)
2. **Analyze errors**: Use `interventions.txt` as systematic cleanup guide
3. **Apply fixes**: Address variable naming, string interpolation, boolean types, unnecessary dependencies
4. **Deploy & validate**:

   ```bash
   # Create resource group
   az group create --name <your-resource-group> --location <azure-region>

   # Deploy with parameter prompts
   az deployment group create --resource-group <rg> --template-file azuredeploy.bicep

   # Or with parameters file
   az deployment group create --resource-group <rg> --template-file azuredeploy.bicep --parameters azuredeploy.parameters.json
   ```

## Key Decompilation Fixes (Applied in this Project)

### Variable Naming: Remove `_var` suffixes

```bicep
// FROM: var vnetName_var = '${prefix}-vnet'
// TO:   var var_vnetName = '${prefix}-vnet'
```

### String Interpolation: Replace concat()

```bicep
// FROM: concat(header, body, footer)
// TO:   '${header}${body}${footer}'
```

### Boolean Types: Convert string booleans

```bicep
// FROM: param acceleratedNetworking string = 'true' @allowed(['true', 'false'])
// TO:   param acceleratedNetworking bool = true @allowed([true, false])
```

### Remove Unnecessary Dependencies

Bicep infers most dependencies automatically - remove explicit `dependsOn` when resource references exist.

## Project-Specific Context

- **FortiGate HA**: Dual VM setup with availability sets and multi-NIC configuration
- **Multi-architecture**: Conditional logic for x64/ARM64 support in VM sizing and image SKUs
- **Parameter files**: Update TODO placeholders in `azuredeploy.parameters.json` before deployment
- **License models**: Template supports BYOL, PAYG, and FortiFlex licensing
