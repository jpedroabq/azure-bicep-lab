
param virtualMachines_windows_vm01_name string = 'windows-vm01'
param networkInterfaces_windows_vm01_nic string = 'windows-vm01-nic' 
// ID da Virtual Network. Substitua pelo ID da sua VNet.
param virtualNetworks_vnet01_externalid string = '' 
// ID do Network Security Group. Substitua pelo ID do seu NSG.
param networkSecurityGroups_nsg1_externalid string = '' 
// Nome do usuário administrador da VM.
param adminUserName string = '' 
// Senha do usuário administrador da VM. Use parâmetro seguro ou variável de ambiente.
@secure()
param adminPassword string 

resource networkInterfaces_windows_vm01264_z1_name_resource 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: networkInterfaces_windows_vm01_nic
  location: 'westeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.4.100'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: '${virtualNetworks_vnet01_externalid}/subnets/subnet01'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg1_externalid
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualMachines_windows_vm01_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_windows_vm01_name
  location: 'westeurope'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ts_v2'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_windows_vm01_name}_OsDisk_1_bc57ec99146543149f823f6f87c623d6'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_windows_vm01_name}_OsDisk_1_bc57ec99146543149f823f6f87c623d6'
          )
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_windows_vm01_name
      adminUsername: adminUserName
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
