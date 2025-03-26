// Parameters
@description('Name of the Virtual Machine')
param vmName string = 'mcvm'

@description('Username for the Virtual Machine')
param adminUsername string = 'mcadmin'

@description('Size of the Virtual Machine')
param vmSize string = 'Standard_B2s'

@description('Ubuntu version SKU (e.g., 20_04-lts, 22_04-lts)')
@allowed([
  '20_04-lts'
  '22_04-lts'
])
param ubuntuOSVersion string = '22_04-lts'

@description('Location for all resources')
param location string = resourceGroup().location

@description('SSH public key for VM authentication')
@secure()
param sshPublicKey string

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
        name: 'AllowSSH'
        properties: {
          priority: 100
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
      {
        name: 'AllowMinecraftJava'
        properties: {
          priority: 200
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '25565'
        }
      }
      {
        name: 'AllowMinecraftBedrock'
        properties: {
          priority: 300
          protocol: 'Udp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '19132'
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
        '' //add your IP here 
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '' //add your IP here 
      ]
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
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: sshPublicKey
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
