// Nome da máquina virtual. 
param virtualMachines_linux_vm01_name string = 'linux-vm01'

// Nome da interface de rede (NIC) da VM. 
param networkInterfaces_linux_vm01368_name string = 'linux-vm01-nic'

// Resource ID da Virtual Network onde a VM será criada.
// Substitua pelo resourceId da sua própria VNet.
param virtualNetworks_vnet01_externalid string = ''

// Resource ID do Network Security Group (NSG) associado à NIC.
// Substitua pelo resourceId do seu NSG.
param networkSecurityGroups_nsg2_externalid string = ''

// Nome do usuário administrador da VM. Defina conforme sua preferência.
param adminUserName string = ''

// Senha do usuário administrador. Fornecida in runtime.
@secure()
param adminPassword string 

resource networkInterfaces_linux_vm01368_name_resource 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: networkInterfaces_linux_vm01368_name
  location: 'westeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.5.100'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: '${virtualNetworks_vnet01_externalid}/subnets/subnet02'
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
      id: networkSecurityGroups_nsg2_externalid
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualMachines_linux_vm01_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_linux_vm01_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ts_v2'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'ubuntu-pro'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_linux_vm01_name}_OsDisk_1_7631b13263c84e39a99fb47f42e7248f'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_linux_vm01_name}_OsDisk_1_7631b13263c84e39a99fb47f42e7248f'
          )
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_linux_vm01_name
      adminUsername: adminUserName
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_linux_vm01368_name_resource.id
          properties: {
            deleteOption: 'Delete'
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
