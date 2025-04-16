## Deploying `azuredeploy.bicep`

### 🚀 Deployment Instructions

1. **Create a Resource Group (if needed):**
   ```bash
   az group create --name <your-resource-group> --location <azure-region>
   ```

2. **Deploy the Bicep template:**
   - With parameter prompts:
     ```bash
     az deployment group create \
       --resource-group <your-resource-group> \
       --template-file azuredeploy.bicep
     ```
   - Or with a parameters file:
     ```bash
     az deployment group create \
       --resource-group <your-resource-group> \
       --template-file azuredeploy.bicep \
       --parameters azuredeploy.parameters.json
     ```

---

### 🔄 Conversion from JSON to Bicep

This Bicep file was generated from an existing ARM JSON template using the [Azure CLI Bicep decompile](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/decompile) tool, the original template is sourced from Fortinet's official [Github](github.com/fortinet/azure-templates):

```bash
az bicep decompile --file azuredeploy.json
```

---

### 🧹 Linting & Fixes (`interventions.txt`)

The following manual adjustments were made post-decompilation:

- Replaced `concat()` with string interpolation (`${}`).
- Fixed resource dependency issues using `dependsOn`.
- Removed unused variables and parameters.
- Reorganized resource creation order for dependency resolution.
- Aligned naming and ID generation for `resourceId()` usage.
- Cleaned up any deprecated syntax or ARM-to-Bicep translation quirks.
