@secure()
param adminPassword string 

module networkModule 'modules/network.bicep' = {
  name: 'networkModule'
}

module vpnGatewayModule 'modules/vpngw.bicep' = {
  name: 'vpnGatewayModule'
}

module linuxVirtualMachineModule 'modules/linux-vm-01.bicep' = {
  name: 'linuxVirtualmachineModule'
  params: {
    adminPassword: adminPassword
  }
}

module windowsVirtualMachineModule 'modules/windows-vm-01.bicep' = {
  name: 'windowsVirtualMachineModule'
  params: {
    adminPassword: adminPassword
  }
}
