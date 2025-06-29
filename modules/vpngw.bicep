// Nome da máquina virtual. 
param virtualNetworkGateways_gw_01_name string = 'gw-01' 
// ID do recurso de IP Público já criado. Substitua pelo ID do seu IP Público.
param publicIPAddresses_azbicep_lab_gwa01_externalid string = '' 
// ID do recurso da Virtual Network. Substitua pelo ID da sua VNet.
param virtualNetworks_vnet01_externalid string = '' 
// ID do Tenant do Azure AD. Exemplo: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/'
param azureTenant string = '' 

resource virtualNetworkGateways_gw_01_name_resource 'Microsoft.Network/virtualNetworkGateways@2024-05-01' = {
  name: virtualNetworkGateways_gw_01_name
  location: 'westeurope'
  properties: {
    enablePrivateIpAddress: false
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_azbicep_lab_gwa01_externalid
          }
          subnet: {
            id: '${virtualNetworks_vnet01_externalid}/subnets/GatewaySubnet'
          }
        }
      }
    ]
    natRules: []
    virtualNetworkGatewayPolicyGroups: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    activeActive: false
    vpnClientConfiguration: {
      vpnClientAddressPool: {
        addressPrefixes: [
          '10.10.1.0/24'
        ]
      }
      vpnClientProtocols: [
        'OpenVPN'
      ]
      vpnAuthenticationTypes: [
        'AAD'
      ]
      vpnClientRootCertificates: []
      vpnClientRevokedCertificates: []
      vngClientConnectionConfigurations: []
      radiusServers: []
      vpnClientIpsecPolicies: []
      aadTenant: 'https://login.microsoftonline.com/${azureTenant}'
      aadAudience: 'c632b3df-fb67-4d84-bdcf-b95ad541b5c8'
      aadIssuer: 'https://sts.windows.net/${azureTenant}'
    }
    bgpSettings: {
      asn: 65515
      bgpPeeringAddress: '10.0.6.254'
      peerWeight: 0
      bgpPeeringAddresses: [
        {
          customBgpIpAddresses: []
        }
      ]
    }
    customRoutes: {
      addressPrefixes: []
    }
    vpnGatewayGeneration: 'Generation1'
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}
