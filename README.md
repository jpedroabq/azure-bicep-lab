# Azure Bicep Lab

Este repositório contém exemplos e laboratórios para aprender e praticar o uso do [Azure Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview), uma linguagem de infraestrutura como código (IaC) para o Azure.

## Objetivo

Aprimorar minhas habilidades em como criar, gerenciar e versionar recursos do Azure utilizando Bicep, promovendo boas práticas de DevOps e automação de infraestrutura.

## Desenho da Infraestrutura

![Image](https://github.com/user-attachments/assets/53bd97b4-ba33-4937-a1ec-de6782764866)

## Estrutura do Repositório

```
.
├── modules/         # Módulos Bicep reutilizáveis
├── main.bicep       # Arquivo principal de implantação
└── README.md        # Esta documentação
```

## Pré-requisitos

- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Bicep CLI](https://learn.microsoft.com/azure/azure-resource-manager/bicep/install)
- Uma conta no [Azure](https://portal.azure.com/)

## Como usar

1. Clone este repositório:
    ```sh
    git clone https://github.com/jpedroabq/azure-bicep-lab.git
    cd azure-bicep-lab
    ```

2. Faça login no Azure:
    ```sh
    az login
    ```

3. Crie a infraestrutura dentro do Azure (substituir resource-group-name):
    ```sh
    az deployment group create --resource-group <resource-group-name> --template-file main.bicep --parameters allowedIp=@allowed-ip.txt
    ```
## Recursos úteis

- [Documentação oficial do Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Exemplos de Bicep](https://github.com/Azure/bicep)

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.



