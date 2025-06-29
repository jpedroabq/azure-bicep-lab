param location string = 'westeurope' 

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet01'
  location: location
  properties: {
     addressSpace: {
       addressPrefixes: [
         '10.0.0.0/21'
       ]
     }
  }
}

resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'subnet01'
  parent: vnet
  properties: {
    addressPrefix: '10.0.4.0/24'
    networkSecurityGroup: {
      id: nsg1.id
    }
  }
}

resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'subnet02'
  parent: vnet
  dependsOn: [subnet1]
  properties: {
    addressPrefix: '10.0.5.0/24'
    networkSecurityGroup: {
      id: nsg2.id
    }
  }

}

resource gwsubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'GatewaySubnet'
  parent: vnet
  properties: {
     addressPrefix: '10.0.6.0/24'
   }
}

resource nsg1 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  location: location
  name: 'nsg1'
  properties: {}
}

resource nsg2 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  location: location
  name: 'nsg2'
  properties: {}
}
