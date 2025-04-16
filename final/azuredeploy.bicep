@description('Username for the Virtual Machine')
param adminUsername string

@description('Password for the Virtual Machine')
@secure()
param adminPassword string

@description('Naming prefix for all deployed resources. The FortiGate VMs will have the suffix \'-FGT-A\' and \'-FGT-B\'. For example if the prefix is \'ACME01\' the FortiGates will be named \'ACME01-FGT-A\' and \'ACME01-FGT-B\'')
param fortiGateNamePrefix string

@description('Identifies whether to to use PAYG (on demand licensing) or BYOL license model (where license is purchased separately)')
@allowed([
  'fortinet_fg-vm'
  'fortinet_fg-vm_payg_2023'
  'fortinet_fg-vm_g2'
  'fortinet_fg-vm_payg_2023_g2'
])
param fortiGateImageSKU_x64 string = 'fortinet_fg-vm'

@description('Identifies whether to to use PAYG (on demand licensing) or BYOL license model (where license is purchased separately')
@allowed([
  'fortinet_fg-vm_arm64'
  'fortinet_fg-vm_payg_2023_arm64'
])
param fortiGateImageSKU_arm64 string = 'fortinet_fg-vm_arm64'

@description('Indicates the instance Architecture of the VM deployment. Intel/AMD or ARM')
@allowed([
  'x64'
  'arm64'
])
param fortiGateInstanceArchitecture string = 'x64'

@description('Select the FortiGate image version')
@allowed([
  'latest'
  '7.6.2'
  '7.6.1'
  '7.6.0'
  '7.4.6'
  '7.4.5'
  '7.4.4'
  '7.4.3'
  '7.4.2'
  '7.4.1'
  '7.4.0'
  '7.2.10'
  '7.2.9'
  '7.2.8'
  '7.2.7'
  '7.2.6'
  '7.2.5'
  '7.2.4'
  '7.2.3'
  '7.2.2'
  '7.2.1'
  '7.2.0'
  '7.0.15'
  '7.0.14'
  '7.0.13'
  '7.0.12'
  '7.0.11'
  '7.0.10'
  '7.0.9'
  '7.0.8'
  '7.0.6'
  '7.0.5'
  '7.0.4'
  '7.0.3'
  '7.0.2'
  '7.0.1'
  '7.0.0'
  '6.4.15'
  '6.4.13'
  '6.4.12'
  '6.4.11'
  '6.4.10'
  '6.4.9'
  '6.4.8'
  '6.4.7'
  '6.4.6'
  '6.4.5'
  '6.4.3'
  '6.4.2'
  '6.4.0'
  '6.2.5'
  '6.2.4'
  '6.2.2'
  '6.2.0'
])
param fortiGateImageVersion_x64 string = '7.4.6'

@description('Select the image version')
@allowed([
  'latest'
  '7.6.2'
  '7.6.1'
  '7.6.0'
  '7.4.6'
  '7.4.5'
  '7.4.4'
  '7.4.3'
  '7.2.10'
  '7.2.9'
  '7.2.8'
])
param fortiGateImageVersion_arm64 string = '7.4.6'

@description('The ARM template provides a basic configuration. Additional configuration can be added here.')
param fortiGateAdditionalCustomData string = ''

@description('Virtual Machine size selection - must be F4 or other instance that supports atleast 4 NICs')
@allowed([
  'Standard_F4s'
  'Standard_F8s'
  'Standard_F16s'
  'Standard_F4'
  'Standard_F8'
  'Standard_F16'
  'Standard_F8s_v2'
  'Standard_F16s_v2'
  'Standard_F32s_v2'
  'Standard_DS3_v2'
  'Standard_DS4_v2'
  'Standard_DS5_v2'
  'Standard_D8s_v3'
  'Standard_D16s_v3'
  'Standard_D32s_v3'
  'Standard_D8_v4'
  'Standard_D16_v4'
  'Standard_D32_v4'
  'Standard_D8s_v4'
  'Standard_D16s_v4'
  'Standard_D32s_v4'
  'Standard_D8a_v4'
  'Standard_D16a_v4'
  'Standard_D32a_v4'
  'Standard_D8as_v4'
  'Standard_D16as_v4'
  'Standard_D32as_v4'
  'Standard_D8_v5'
  'Standard_D16_v5'
  'Standard_D32_v5'
  'Standard_D8s_v5'
  'Standard_D16s_v5'
  'Standard_D32s_v5'
  'Standard_D8as_v5'
  'Standard_D16as_v5'
  'Standard_D32as_v5'
  'Standard_D8ads_v5'
  'Standard_D16ads_v5'
  'Standard_D32ads_v5'
])
param instanceType_x64 string = 'Standard_F4s'

@description('Virtual Machine size selection - must be an instance that supports atleast 4 NICs')
@allowed([
  'Standard_D8ps_v6'
  'Standard_D16ps_v6'
  'Standard_D32ps_v6'
  'Standard_D8ps_v5'
  'Standard_D16ps_v5'
  'Standard_D32ps_v5'
  'Standard_D8pds_v5'
  'Standard_D16pds_v5'
  'Standard_D32pds_v5'
  'Standard_D8pls_v5'
  'Standard_D16pls_v5'
  'Standard_D32pls_v5'
  'Standard_D8plds_v5'
  'Standard_D16plds_v5'
  'Standard_D32plds_v5'
  'Standard_E8ps_v5'
  'Standard_E16ps_v5'
  'Standard_E32ps_v5'
  'Standard_E8pds_v5'
  'Standard_E16pds_v5'
  'Standard_E32pds_v5'
])
param instanceType_arm64 string = 'Standard_D8ps_v6'

@description('Deploy FortiGate VMs in an Availability Set or Availability Zones. If Availability Zones deployment is selected but the location does not support Availability Zones an Availability Set will be deployed. If Availability Zones deployment is selected and Availability Zones are available in the location, FortiGate A will be placed in Zone 1, FortiGate B will be placed in Zone 2')
@allowed([
  'Availability Set'
  'Availability Zones'
])
param availabilityOptions string = 'Availability Zones'

@description('Accelerated Networking enables direct connection between the VM and network card. Only available on 2 CPU F/Fs and 4 CPU D/Dsv2, D/Dsv3, E/Esv3, Fsv2, Lsv2, Ms/Mms and Ms/Mmsv2')
@allowed([
  true
  false
])
param acceleratedNetworking bool = true

@description('Accelerated connections provides an enhanced bandwidth at an additional cost')
param acceleratedConnections bool = false

@description('Accelerated Connections Auxiliary SKU bandwidth Tiers')
@allowed([
  'A1'
  'A2'
  'A4'
  'A8'
])
param acceleratedConnectionsSku string = 'A1'

@description('Public IP for the Load Balancer for inbound and outbound data of the FortiGate VMs')
@allowed([
  'new'
  'existing'
])
param publicIP1NewOrExisting string = 'new'

@description('Name of Public IP address, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-fgt-pip\' as the suffix')
param publicIP1Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP1ResourceGroup string = ''

@description('Public IP for management of the FortiGate A. This deployment uses a Standard SKU Azure Load Balancer and requires a Standard SKU public IP. Microsoft Azure offers a migration path from a basic to standard SKU public IP. The management IP\'s for both FortiGate can be set to none. If no alternative internet access is provided, the SDN Connector functionality for dynamic objects will not work.')
@allowed([
  'new'
  'existing'
  'none'
])
param publicIP2NewOrExisting string = 'new'

@description('Name of Public IP address, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-fgt-a-mgmt-pip\' as the suffix')
param publicIP2Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP2ResourceGroup string = ''

@description('Public IP for management of the FortiGate B. This deployment uses a Standard SKU Azure Load Balancer and requires a Standard SKU public IP. Microsoft Azure offers a migration path from a basic to standard SKU public IP. The management IP\'s for both FortiGate can be set to none. If no alternative internet access is provided, the SDN Connector functionality for both HA failover and dynamic objects will not work.')
@allowed([
  'new'
  'existing'
  'none'
])
param publicIP3NewOrExisting string = 'new'

@description('Name of Public IP address, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-fgt-b-mgmt-pip\' as the suffix')
param publicIP3Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP3ResourceGroup string = ''

@description('Identify whether to use a new or existing vnet')
@allowed([
  'new'
  'existing'
])
param vnetNewOrExisting string = 'new'

@description('Name of the Azure virtual network, required if utilizing an existing VNET. If no name is provided the default name will be the Resource Group Name as the Prefix and \'-VNET\' as the suffix')
param vnetName string = ''

@description('Resource Group containing the existing virtual network, leave blank if a new VNET is being utilized')
param vnetResourceGroup string = ''

@description('Virtual Network Address prefix')
param vnetAddressPrefix string = '172.16.136.0/22'

@description('Subnet 1 Name')
param subnet1Name string = 'externalsubnet'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '172.16.136.0/26'

@description('Subnet 1 start address, 2 consecutive private IPs are required')
param subnet1StartAddress string = '172.16.136.4'

@description('Subnet 2 Name')
param subnet2Name string = 'internalsubnet'

@description('Subnet 2 Prefix')
param subnet2Prefix string = '172.16.136.64/26'

@description('Subnet 2 start address, 3 consecutive private IPs are required')
param subnet2StartAddress string = '172.16.136.68'

@description('Subnet 3 Name')
param subnet3Name string = 'hasyncsubnet'

@description('Subnet 3 Prefix')
param subnet3Prefix string = '172.16.136.128/26'

@description('Subnet 3 start address, 2 consecutive private IPs are required')
param subnet3StartAddress string = '172.16.136.132'

@description('Subnet 4 Name')
param subnet4Name string = 'hamanagementsubnet'

@description('Subnet 4 Prefix')
param subnet4Prefix string = '172.16.136.192/26'

@description('Subnet 4 start address, 2 consecutive private IPs are required')
param subnet4StartAddress string = '172.16.136.196'

@description('Subnet 5 Name')
param subnet5Name string = 'protectedasubnet'

@description('Subnet 5 Prefix')
param subnet5Prefix string = '172.16.137.0/24'

@description('Enable Serial Console')
@allowed([
  'yes'
  'no'
])
param serialConsole string = 'yes'

@description('Connect to FortiManager')
@allowed([
  'yes'
  'no'
])
param fortiManager string = 'no'

@description('FortiManager IP or DNS name to connect to on port TCP/541')
param fortiManagerIP string = ''

@description('FortiManager serial number to add the deployed FortiGate into the FortiManager')
param fortiManagerSerial string = ''

@description('Primary FortiGate BYOL license content')
param fortiGateLicenseBYOLA string = ''

@description('Secondary FortiGate BYOL license content')
param fortiGateLicenseBYOLB string = ''

@description('Primary FortiGate BYOL FortiFlex license token')
param fortiGateLicenseFortiFlexA string = ''

@description('Secondary FortiGate BYOL FortiFlex license token')
param fortiGateLicenseFortiFlexB string = ''

@description('By default, the deployment will use Azure Marketplace images. In specific cases, using BYOL custom FortiGate images can be deployed. This requires a reference ')
param customImageReference string = ''

@description('Location for all resources.')
param location string = resourceGroup().location
param tagsByResource object = {}
param fortinetTags object = {
  publisher: 'Fortinet'
  template: 'Active-Passive-ELB-ILB'
  provider: '6EB3B02F-50E5-4A3E-8CB8-2E12925831AP'
}

var imagePublisher = 'fortinet'
var imageOffer = 'fortinet_fortigate-vm_v5'
var fortiGateImageSKU = ((fortiGateInstanceArchitecture == 'arm64') ? fortiGateImageSKU_arm64 : fortiGateImageSKU_x64)
var instanceType = ((fortiGateInstanceArchitecture == 'arm64') ? instanceType_arm64 : instanceType_x64)
var fortiGateImageVersion = ((fortiGateInstanceArchitecture == 'arm64')
  ? fortiGateImageVersion_arm64
  : fortiGateImageVersion_x64)
var availabilitySetName = '${fortiGateNamePrefix}-AvailabilitySet'
var availabilitySetId = {
  id: availabilitySet.id
}
var var_vnetName = ((vnetName == '') ? '${fortiGateNamePrefix}-vnet' : vnetName)
var subnet1Id = ((vnetNewOrExisting == 'new')
  ? resourceId('Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet1Name)
  : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet1Name))
var subnet2Id = ((vnetNewOrExisting == 'new')
  ? resourceId('Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet2Name)
  : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet2Name))
var subnet3Id = ((vnetNewOrExisting == 'new')
  ? resourceId('Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet3Name)
  : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet3Name))
var subnet4Id = ((vnetNewOrExisting == 'new')
  ? resourceId('Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet4Name)
  : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', var_vnetName, subnet4Name))
var fgaVmName = '${fortiGateNamePrefix}-FGT-A'
var fgbVmName = '${fortiGateNamePrefix}-FGT-B'
var fmgCustomData = ((fortiManager == 'yes')
  ? '\nconfig system central-management\nset type fortimanager\n set fmg ${fortiManagerIP}\nset serial-number ${fortiManagerSerial}\nend\n config system interface\n edit port1\n append allowaccess fgfm\n end\n config system interface\n edit port2\n append allowaccess fgfm\n end\n'
  : '')
var customDataHeader = 'Content-Type: multipart/mixed; boundary="12345"\nMIME-Version: 1.0\n\n--12345\nContent-Type: text/plain; charset="us-ascii"\nMIME-Version: 1.0\nContent-Transfer-Encoding: 7bit\nContent-Disposition: attachment; filename="config"\n\n'
var fgaCustomDataBody = 'config system sdn-connector\nedit AzureSDN\nset type azure\nnext\nend\nconfig router static\n edit 1\n set gateway ${sn1GatewayIP}\n set device port1\n next\n edit 2\n set dst ${vnetAddressPrefix}\n set gateway ${sn2GatewayIP}\n set device port2\n next\n edit 3\nset dst 168.63.129.16 255.255.255.255\nset device port2\n set gateway ${sn2GatewayIP}\n next\nedit 4\nset dst 168.63.129.16 255.255.255.255\nset device port1\n set gateway ${sn1GatewayIP}\n next\n end\n config system probe-response\n set http-probe-value OK\n set mode http-probe\n end\n config system interface\n edit port1\n set mode static\n set ip ${sn1IPfga}/${sn1CIDRmask}\n set description external\n set allowaccess probe-response\n next\n edit port2\n set mode static\n set ip ${sn2IPfga}/${sn2CIDRmask}\n set description internal\n set allowaccess probe-response\n next\n edit port3\n set mode static\n set ip ${sn3IPfga}/${sn3CIDRmask}\n set description hasyncport\n next\n edit port4\n set mode static\n set ip ${sn4IPfga}/${sn4CIDRmask}\n set description hammgmtport\n set allowaccess ping https ssh ftm\n next\n end\n config system ha\n set group-id 1\n set group-name AzureHA\n set mode a-p\n set hbdev port3 100\n set session-pickup enable\n set session-pickup-connectionless enable\n set ha-mgmt-status enable\n config ha-mgmt-interfaces\n edit 1\n set interface port4\n set gateway ${sn4GatewayIP}\n next\n end\n set override disable\n set priority 255\n set unicast-hb enable\n set unicast-hb-peerip ${sn3IPfgb}\n set password ${adminPassword}\n end\n${fmgCustomData}${fortiGateAdditionalCustomData}\n'
var fgbCustomDataBody = 'config system sdn-connector\nedit AzureSDN\nset type azure\nnext\nend\nconfig router static\n edit 1\n set gateway ${sn1GatewayIP}\n set device port1\n next\n edit 2\n set dst ${vnetAddressPrefix}\n set gateway ${sn2GatewayIP}\n set device port2\n next\n edit 3\nset dst 168.63.129.16 255.255.255.255\nset device port2\n set gateway ${sn2GatewayIP}\n next\nedit 4\nset dst 168.63.129.16 255.255.255.255\nset device port1\n set gateway ${sn1GatewayIP}\n next\n end\n config system probe-response\n set http-probe-value OK\n set mode http-probe\n end\n config system interface\n edit port1\n set mode static\n set ip ${sn1IPfgb}/${sn1CIDRmask}\n set description external\n set allowaccess probe-response\n next\n edit port2\n set mode static\n set ip ${sn2IPfgb}/${sn2CIDRmask}\n set description internal\n set allowaccess probe-response\n next\n edit port3\n set mode static\n set ip ${sn3IPfgb}/${sn3CIDRmask}\n set description hasyncport\n next\n edit port4\n set mode static\n set ip ${sn4IPfgb}/${sn4CIDRmask}\n set description hammgmtport\n set allowaccess ping https ssh ftm\n next\n end\n config system ha\n set group-id 1\n set group-name AzureHA\n set mode a-p\n set hbdev port3 100\n set session-pickup enable\n set session-pickup-connectionless enable\n set ha-mgmt-status enable\n config ha-mgmt-interfaces\n edit 1\n set interface port4\n set gateway ${sn4GatewayIP}\n next\n end\n set override disable\n set priority 1\n set unicast-hb enable\n set unicast-hb-peerip ${sn3IPfga}\n set password ${adminPassword}\n end\n${fmgCustomData}${fortiGateAdditionalCustomData}\n'
var customDataLicenseHeader = '--12345\nContent-Type: text/plain; charset="us-ascii"\nMIME-Version: 1.0\nContent-Transfer-Encoding: 7bit\nContent-Disposition: attachment; filename="license"\n\n'
var customDataFooter = '\n--12345--\n'
var fgaCustomDataFortiFlex = ((fortiGateLicenseFortiFlexA == '') ? '' : 'LICENSE-TOKEN:${fortiGateLicenseFortiFlexA}\n')
var fgbCustomDataFortiFlex = ((fortiGateLicenseFortiFlexB == '') ? '' : 'LICENSE-TOKEN:${fortiGateLicenseFortiFlexB}\n')
var fgaCustomDataCombined = '${customDataHeader}${fgaCustomDataBody}${customDataLicenseHeader}${fgaCustomDataFortiFlex}${fortiGateLicenseBYOLA}${customDataFooter}'
var fgbCustomDataCombined = '${customDataHeader}${fgbCustomDataBody}${customDataLicenseHeader}${fgbCustomDataFortiFlex}${fortiGateLicenseBYOLB}${customDataFooter}'

var fgaCustomData = base64((((fortiGateLicenseBYOLA == '') && (fortiGateLicenseFortiFlexA == ''))
  ? fgaCustomDataBody
  : fgaCustomDataCombined))
var fgbCustomData = base64((((fortiGateLicenseBYOLB == '') && (fortiGateLicenseFortiFlexB == ''))
  ? fgbCustomDataBody
  : fgbCustomDataCombined))
var routeTableName = '${fortiGateNamePrefix}-routetable-${subnet5Name}'
var routeTableId = routeTable.id
var fgaNic1Name = '${fgaVmName}-nic1'
var fgaNic1Id = fgaNic1.id
var fgbNic1Name = '${fgbVmName}-nic1'
var fgbNic1Id = fgbNic1.id
var fgaNic2Name = '${fgaVmName}-nic2'
var fgaNic2Id = fgaNic2.id
var fgbNic2Name = '${fgbVmName}-nic2'
var fgbNic2Id = fgbNic2.id
var fgaNic3Name = '${fgaVmName}-nic3'
var fgaNic3Id = fgaNic3.id
var fgbNic3Name = '${fgbVmName}-nic3'
var fgbNic3Id = fgbNic3.id
var fgaNic4Name = '${fgaVmName}-nic4'
var fgaNic4Id = fgaNic4.id
var fgbNic4Name = '${fgbVmName}-nic4'
var fgbNic4Id = fgbNic4.id
var serialConsoleEnabled = ((serialConsole == 'yes') ? true : false)
var var_publicIP1Name = ((publicIP1Name == '') ? '${fortiGateNamePrefix}-fgt-pip' : publicIP1Name)
var publicIP1Id = ((publicIP1NewOrExisting == 'new')
  ? publicIP1.id
  : resourceId(publicIP1ResourceGroup, 'Microsoft.Network/publicIPAddresses', var_publicIP1Name))
var var_publicIP2Name = ((publicIP2Name == '') ? '${fortiGateNamePrefix}-fgt-a-mgmt-pip' : publicIP2Name)
var publicIP2Id = ((publicIP2NewOrExisting == 'new')
  ? publicIP2.id
  : resourceId(publicIP2ResourceGroup, 'Microsoft.Network/publicIPAddresses', var_publicIP2Name))
var publicIPAddress2Id = {
  id: publicIP2Id
}
var var_publicIP3Name = ((publicIP3Name == '') ? '${fortiGateNamePrefix}-fgt-b-mgmt-pip' : publicIP3Name)
var publicIP3Id = ((publicIP3NewOrExisting == 'new')
  ? publicIP3.id
  : resourceId(publicIP3ResourceGroup, 'Microsoft.Network/publicIPAddresses', var_publicIP3Name))
var publicIPAddress3Id = {
  id: publicIP3Id
}
var nsgName = '${fortiGateNamePrefix}-${uniqueString(resourceGroup().id)}-nsg'
var nsgId = nsg.id
var sn1IPArray = split(subnet1Prefix, '.')
var sn1IPArray2ndString = string(sn1IPArray[3])
var sn1IPArray2nd = split(sn1IPArray2ndString, '/')
var sn1CIDRmask = string(int(sn1IPArray2nd[1]))
var sn1IPArray3 = string((int(sn1IPArray2nd[0]) + 1))
var sn1IPArray2 = string(int(sn1IPArray[2]))
var sn1IPArray1 = string(int(sn1IPArray[1]))
var sn1IPArray0 = string(int(sn1IPArray[0]))
var sn1GatewayIP = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${sn1IPArray3}'
var sn1IPStartAddress = split(subnet1StartAddress, '.')
var sn1IPfga = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${int(sn1IPStartAddress[3])}'
var sn1IPfgb = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${(int(sn1IPStartAddress[3])+1)}'
var sn2IPArray = split(subnet2Prefix, '.')
var sn2IPArray2ndString = string(sn2IPArray[3])
var sn2IPArray2nd = split(sn2IPArray2ndString, '/')
var sn2CIDRmask = string(int(sn2IPArray2nd[1]))
var sn2IPArray3 = string((int(sn2IPArray2nd[0]) + 1))
var sn2IPArray2 = string(int(sn2IPArray[2]))
var sn2IPArray1 = string(int(sn2IPArray[1]))
var sn2IPArray0 = string(int(sn2IPArray[0]))
var sn2GatewayIP = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${sn2IPArray3}'
var sn2IPStartAddress = split(subnet2StartAddress, '.')
var sn2IPlb = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${int(sn2IPStartAddress[3])}'
var sn2IPfga = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${(int(sn2IPStartAddress[3])+1)}'
var sn2IPfgb = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${(int(sn2IPStartAddress[3])+2)}'
var sn3IPArray = split(subnet3Prefix, '.')
var sn3IPArray2ndString = string(sn3IPArray[3])
var sn3IPArray2nd = split(sn3IPArray2ndString, '/')
var sn3CIDRmask = string(int(sn3IPArray2nd[1]))
var sn3IPArray2 = string(int(sn3IPArray[2]))
var sn3IPArray1 = string(int(sn3IPArray[1]))
var sn3IPArray0 = string(int(sn3IPArray[0]))
var sn3IPStartAddress = split(subnet3StartAddress, '.')
var sn3IPfga = '${sn3IPArray0}.${sn3IPArray1}.${sn3IPArray2}.${int(sn3IPStartAddress[3])}'
var sn3IPfgb = '${sn3IPArray0}.${sn3IPArray1}.${sn3IPArray2}.${(int(sn3IPStartAddress[3])+1)}'
var sn4IPArray = split(subnet4Prefix, '.')
var sn4IPArray2ndString = string(sn4IPArray[3])
var sn4IPArray2nd = split(sn4IPArray2ndString, '/')
var sn4CIDRmask = string(int(sn4IPArray2nd[1]))
var sn4IPArray3 = string((int(sn4IPArray2nd[0]) + 1))
var sn4IPArray2 = string(int(sn4IPArray[2]))
var sn4IPArray1 = string(int(sn4IPArray[1]))
var sn4IPArray0 = string(int(sn4IPArray[0]))
var sn4GatewayIP = '${sn4IPArray0}.${sn4IPArray1}.${sn4IPArray2}.${sn4IPArray3}'
var sn4IPStartAddress = split(subnet4StartAddress, '.')
var sn4IPfga = '${sn4IPArray0}.${sn4IPArray1}.${sn4IPArray2}.${int(sn4IPStartAddress[3])}'
var sn4IPfgb = '${sn4IPArray0}.${sn4IPArray1}.${sn4IPArray2}.${(int(sn4IPStartAddress[3])+1)}'
var internalLBName = '${fortiGateNamePrefix}-internalloadbalancer'
var internalLBFEName = '${fortiGateNamePrefix}-ILB-${subnet2Name}-frontend'
var internalLBFEId = resourceId(
  'Microsoft.Network/loadBalancers/frontendIPConfigurations/',
  internalLBName,
  internalLBFEName
)
var internalLBBEName = '${fortiGateNamePrefix}-ILB-${subnet2Name}-backend'
var internalLBBEId = resourceId(
  'Microsoft.Network/loadBalancers/backendAddressPools',
  internalLBName,
  internalLBBEName
)
var internalLBProbeName = 'lbprobe'
var internalLBProbeId = resourceId('Microsoft.Network/loadBalancers/probes/', internalLBName, internalLBProbeName)
var externalLBName = '${fortiGateNamePrefix}-externalloadbalancer'
var externalLBFEName = '${fortiGateNamePrefix}-elb-${subnet1Name}-frontend'
var externalLBFEId = resourceId(
  'Microsoft.Network/loadBalancers/frontendIPConfigurations/',
  externalLBName,
  externalLBFEName
)
var externalLBBEName = '${fortiGateNamePrefix}-elb-${subnet1Name}-backend'
var externalLBBEId = resourceId(
  'Microsoft.Network/loadBalancers/backendAddressPools',
  externalLBName,
  externalLBBEName
)
var externalLBProbeName = 'lbprobe'
var externalLBProbeId = resourceId('Microsoft.Network/loadBalancers/probes/', externalLBName, externalLBProbeName)
var useAZ = ((!empty(pickZones('Microsoft.Compute', 'virtualMachines', location))) && (availabilityOptions == 'Availability Zones'))
var pipZones = (useAZ ? pickZones('Microsoft.Network', 'publicIPAddresses', location, 3) : null)
var zone1 = [
  '1'
]
var zone2 = [
  '2'
]
var imageReferenceMarketplace = {
  publisher: imagePublisher
  offer: imageOffer
  sku: fortiGateImageSKU
  version: fortiGateImageVersion
}
var imageReferenceCustomImage = {
  id: customImageReference
}
var virtualMachinePlan = {
  name: fortiGateImageSKU
  publisher: imagePublisher
  product: imageOffer
}
var fastpathtag = {
  fastpathenabled: (((acceleratedNetworking == true) && acceleratedConnections) ? true : false)
}
var auxiliaryMode = (((acceleratedNetworking == true) && acceleratedConnections) ? 'AcceleratedConnections' : 'None')
var auxiliarySku = (((acceleratedNetworking == true) && acceleratedConnections) ? acceleratedConnectionsSku : 'None')

resource availabilitySet 'Microsoft.Compute/availabilitySets@2023-09-01' = if (!useAZ) {
  name: availabilitySetName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Compute/availabilitySets')
    ? union(fortinetTags, tagsByResource['Microsoft.Compute/availabilitySets'])
    : fortinetTags)
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 2
  }
  sku: {
    name: 'Aligned'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-06-01' = if (vnetNewOrExisting == 'new') {
  name: var_vnetName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/virtualNetworks')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/virtualNetworks'])
    : fortinetTags)
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
        }
      }
      {
        name: subnet3Name
        properties: {
          addressPrefix: subnet3Prefix
        }
      }
      {
        name: subnet4Name
        properties: {
          addressPrefix: subnet4Prefix
        }
      }
      {
        name: subnet5Name
        properties: {
          addressPrefix: subnet5Prefix
          routeTable: {
            id: routeTableId
          }
        }
      }
    ]
  }
}

resource routeTable 'Microsoft.Network/routeTables@2023-06-01' = {
  name: routeTableName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/routeTables')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/routeTables'])
    : fortinetTags)
  properties: {
    routes: [
      {
        name: 'toDefault'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: sn2IPlb
        }
      }
      {
        name: 'toVNET'
        properties: {
          addressPrefix: vnetAddressPrefix
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: sn2IPlb
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: nsgName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkSecurityGroups')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkSecurityGroups'])
    : fortinetTags)
  properties: {
    securityRules: [
      {
        name: 'AllowAllInbound'
        properties: {
          description: 'Allow all in'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowAllOutbound'
        properties: {
          description: 'Allow all out'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 105
          direction: 'Outbound'
        }
      }
    ]
  }
}

resource publicIP1 'Microsoft.Network/publicIPAddresses@2023-06-01' = if (publicIP1NewOrExisting == 'new') {
  name: var_publicIP1Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/publicIPAddresses')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/publicIPAddresses'])
    : fortinetTags)
  sku: {
    name: 'Standard'
  }
  zones: pipZones
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: '${toLower(fortiGateNamePrefix)}-${uniqueString(resourceGroup().id)}'
    }
  }
}

resource publicIP2 'Microsoft.Network/publicIPAddresses@2023-06-01' = if (publicIP2NewOrExisting == 'new') {
  name: var_publicIP2Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/publicIPAddresses')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/publicIPAddresses'])
    : fortinetTags)
  sku: {
    name: 'Standard'
  }
  zones: pipZones
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource publicIP3 'Microsoft.Network/publicIPAddresses@2023-06-01' = if (publicIP3NewOrExisting == 'new') {
  name: var_publicIP3Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/publicIPAddresses')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/publicIPAddresses'])
    : fortinetTags)
  sku: {
    name: 'Standard'
  }
  zones: pipZones
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource externalLB 'Microsoft.Network/loadBalancers@2023-06-01' = {
  name: externalLBName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/loadBalancers')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/loadBalancers'])
    : fortinetTags)
  sku: {
    name: 'Standard'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: externalLBFEName
        properties: {
          publicIPAddress: {
            id: publicIP1Id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: externalLBBEName
      }
    ]
    loadBalancingRules: [
      {
        properties: {
          frontendIPConfiguration: {
            id: externalLBFEId
          }
          backendAddressPool: {
            id: externalLBBEId
          }
          probe: {
            id: externalLBProbeId
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: true
          idleTimeoutInMinutes: 5
        }
        name: 'PublicLBRule-FE1-http'
      }
      {
        properties: {
          frontendIPConfiguration: {
            id: externalLBFEId
          }
          backendAddressPool: {
            id: externalLBBEId
          }
          probe: {
            id: externalLBProbeId
          }
          protocol: 'Udp'
          frontendPort: 10551
          backendPort: 10551
          enableFloatingIP: true
          idleTimeoutInMinutes: 5
        }
        name: 'PublicLBRule-FE1-udp10551'
      }
    ]
    probes: [
      {
        properties: {
          protocol: 'Tcp'
          port: 8008
          intervalInSeconds: 5
          probeThreshold: 2
        }
        name: externalLBProbeName
      }
    ]
  }
}

resource internalLB 'Microsoft.Network/loadBalancers@2023-06-01' = {
  name: internalLBName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/loadBalancers')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/loadBalancers'])
    : fortinetTags)
  sku: {
    name: 'Standard'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: internalLBFEName
        properties: {
          privateIPAddress: sn2IPlb
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet2Id
          }
        }
        zones: (useAZ ? pipZones : null)
      }
    ]
    backendAddressPools: [
      {
        name: internalLBBEName
      }
    ]
    loadBalancingRules: [
      {
        properties: {
          frontendIPConfiguration: {
            id: internalLBFEId
          }
          backendAddressPool: {
            id: internalLBBEId
          }
          probe: {
            id: internalLBProbeId
          }
          protocol: 'all'
          frontendPort: 0
          backendPort: 0
          enableFloatingIP: true
          idleTimeoutInMinutes: 5
        }
        name: 'lbruleFE2all'
      }
    ]
    probes: [
      {
        properties: {
          protocol: 'Tcp'
          port: 8008
          intervalInSeconds: 5
          probeThreshold: 2
        }
        name: internalLBProbeName
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}

resource fgaNic1 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgaNic1Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'], fastpathtag)
    : union(fortinetTags, fastpathtag))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: sn1IPfga
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet1Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: externalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    auxiliaryMode: auxiliaryMode
    auxiliarySku: auxiliarySku
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource fgbNic1 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgbNic1Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'], fastpathtag)
    : union(fortinetTags, fastpathtag))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: sn1IPfgb
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet1Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: externalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    auxiliaryMode: auxiliaryMode
    auxiliarySku: auxiliarySku
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource fgaNic2 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgaNic2Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'], fastpathtag)
    : union(fortinetTags, fastpathtag))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn2IPfga
          subnet: {
            id: subnet2Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: internalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    auxiliaryMode: auxiliaryMode
    auxiliarySku: auxiliarySku
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    internalLB
  ]
}

resource fgbNic2 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgbNic2Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'], fastpathtag)
    : union(fortinetTags, fastpathtag))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn2IPfgb
          subnet: {
            id: subnet2Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: internalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    auxiliaryMode: auxiliaryMode
    auxiliarySku: auxiliarySku
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    internalLB
  ]
}

resource fgaNic3 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgaNic3Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'])
    : fortinetTags)
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn3IPfga
          subnet: {
            id: subnet3Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource fgbNic3 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgbNic3Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'])
    : fortinetTags)
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn3IPfgb
          subnet: {
            id: subnet3Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource fgaNic4 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgaNic4Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'])
    : fortinetTags)
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn4IPfga
          publicIPAddress: ((publicIP2NewOrExisting != 'none') ? publicIPAddress2Id : null)
          subnet: {
            id: subnet4Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource fgbNic4 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: fgbNic4Name
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Network/networkInterfaces')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'])
    : fortinetTags)
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn4IPfgb
          publicIPAddress: ((publicIP3NewOrExisting != 'none') ? publicIPAddress3Id : null)
          subnet: {
            id: subnet4Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource fgaVm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: fgaVmName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Compute/virtualMachines')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'])
    : fortinetTags)
  identity: {
    type: 'SystemAssigned'
  }
  zones: (useAZ ? zone1 : null)
  plan: ((((fortiGateImageSKU == 'fortinet_fg-vm') || (fortiGateImageSKU == 'fortinet_fg-vm_arm64')) && (customImageReference != ''))
    ? null
    : virtualMachinePlan)
  properties: {
    hardwareProfile: {
      vmSize: instanceType
    }
    availabilitySet: ((!useAZ) ? availabilitySetId : null)
    osProfile: {
      computerName: fgaVmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      customData: fgaCustomData
    }
    storageProfile: {
      imageReference: ((((fortiGateImageSKU == 'fortinet_fg-vm') || (fortiGateImageSKU == 'fortinet_fg-vm_arm64')) && (customImageReference != ''))
        ? imageReferenceCustomImage
        : imageReferenceMarketplace)
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
        {
          diskSizeGB: 30
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: fgaNic1Id
        }
        {
          properties: {
            primary: false
          }
          id: fgaNic2Id
        }
        {
          properties: {
            primary: false
          }
          id: fgaNic3Id
        }
        {
          properties: {
            primary: false
          }
          id: fgaNic4Id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: serialConsoleEnabled
      }
    }
  }
}

resource fgbVm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: fgbVmName
  location: location
  tags: (contains(tagsByResource, 'Microsoft.Compute/virtualMachines')
    ? union(fortinetTags, tagsByResource['Microsoft.Network/networkInterfaces'])
    : fortinetTags)
  identity: {
    type: 'SystemAssigned'
  }
  zones: (useAZ ? zone2 : null)
  plan: ((((fortiGateImageSKU == 'fortinet_fg-vm') || (fortiGateImageSKU == 'fortinet_fg-vm_arm64')) && (customImageReference != ''))
    ? null
    : virtualMachinePlan)
  properties: {
    hardwareProfile: {
      vmSize: instanceType
    }
    availabilitySet: ((!useAZ) ? availabilitySetId : null)
    osProfile: {
      computerName: fgbVmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      customData: fgbCustomData
    }
    storageProfile: {
      imageReference: ((((fortiGateImageSKU == 'fortinet_fg-vm') || (fortiGateImageSKU == 'fortinet_fg-vm_arm64')) && (customImageReference != ''))
        ? imageReferenceCustomImage
        : imageReferenceMarketplace)
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
        {
          diskSizeGB: 30
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: fgbNic1Id
        }
        {
          properties: {
            primary: false
          }
          id: fgbNic2Id
        }
        {
          properties: {
            primary: false
          }
          id: fgbNic3Id
        }
        {
          properties: {
            primary: false
          }
          id: fgbNic4Id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: serialConsoleEnabled
      }
    }
  }
}

output fortiGatePublicIP string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP1Id).ipAddress : '')
output fortiGateFQDN string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP1Id).dnsSettings.fqdn : '')
output fortiGateAManagementPublicIP string = ((publicIP2NewOrExisting == 'new') ? reference(publicIP2Id).ipAddress : '')
output fortiGateBManagementPublicIP string = ((publicIP3NewOrExisting == 'new') ? reference(publicIP3Id).ipAddress : '')
