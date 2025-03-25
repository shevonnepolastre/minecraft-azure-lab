// Parameters
@description('Name of the Virtual Machine')
param vmName string = 'mcvm'

@description('Username for the Virtual Machine')
param adminUsername string = 'mcadmin'

@description('Size of the Virtual Machine')
param vmSize string = 'Standard_B2s'

@description('Ubuntu version')
param ubuntuOSVersion string = '22.04-LTS'

@description('Location for all resources')
param location string = resourceGroup().location

// Variables
var networkInterfaceName = '${vmName}-nic'
var virtualNetworkName = '${vmName}-vnet'
var subnetName = 'default'
var networkSecurityGroupName = '${vmName}-nsg'
var publicIPAddressName = '${vmName}-pip'

// Network Security Group
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }

        name: 'AllowAny25565Inbound'
        properties: {
          priority: 310
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '0.0.0.0/0'
          destinationPortRange: '25565
        }

        name: 'AllowAny19132Inbound'
        properties: {
          priority: 100
          protocol: 'Udp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '19132
        }
      }
    ]
  }
}

// Public IP
resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Virtual Network
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}

// Network Interface
resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
        }
      }
    ]
  }
}

// Linux Virtual Machine
resource linuxVM 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: false
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: '-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
' // Replace with your SSH public key
            }
          ]
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: ubuntuOSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}

// Outputs
output vmId string = linuxVM.id
output adminUsername string = adminUsername
output publicIPAddress string = publicIPAddress.properties.ipAddress
