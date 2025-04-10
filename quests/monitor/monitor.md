# Monitoring


# Log Analytics Workspace

Created using ARM template with a parameter file. Tried to use the "Free" SKU but got errors cause it's no longer allowed.  

Used CLI to push template to create resource:

```cli

az deployment group create \
  --name AzureMonitorDeployment \
  --resource-group MinecraftRG \
  --template-file log-analytics-creation.json \
  --parameters @log-analyticsws-param.json

```

Got the following message:

```
{
  "id": "/subscriptions/subID/resourceGroups/MinecraftRG/providers/Microsoft.Resources/deployments/AzureMonitorDeployment",
  "location": null,
  "name": "AzureMonitorDeployment",
  "properties": {
    "correlationId": "#####",
    "debugSetting": null,
    "dependencies": [
      {
        "dependsOn": [
          {
            "id": "/subscriptions/subID/resourceGroups/MinecraftRG/providers/Microsoft.OperationalInsights/workspaces/minecraft-logs",
            "resourceGroup": "MinecraftRG",
            "resourceName": "minecraft-logs",
            "resourceType": "Microsoft.OperationalInsights/workspaces"
          }
        ],
        "id": "/subscriptions/subID/resourceGroups/MinecraftRG/providers/Microsoft.OperationalInsights/workspaces/minecraft-logs/tables/Heartbeat",
        "resourceGroup": "MinecraftRG",
        "resourceName": "minecraft-logs/Heartbeat",
        "resourceType": "Microsoft.OperationalInsights/workspaces/tables"
      }
    ],
    "duration": null,
    "error": null,
    "mode": "Incremental",
    "onErrorDeployment": null,
    "outputResources": [
      {
        "id": "/subscriptions/subID/resourceGroups/MinecraftRG/providers/Microsoft.OperationalInsights/workspaces/minecraft-logs",
        "resourceGroup": "MinecraftRG"
      },
      {
        "id": "/subscriptions/subID/resourceGroups/MinecraftRG/providers/Microsoft.OperationalInsights/workspaces/minecraft-logs/tables/Heartbeat",
        "resourceGroup": "MinecraftRG"
      }
    ],
    "outputs": null,
    "parameters": {
      "heartbeatTableRetention": {
        "type": "Int",
        "value": 30
      },
      "location": {
        "type": "String",
        "value": "eastus2"
      },
      "resourcePermissions": {
        "type": "Bool",
        "value": true
      },
      "retentionInDays": {
        "type": "Int",
        "value": 30
      },
      "sku": {
        "type": "String",
        "value": "pergb2018"
      },
      "workspaceName": {
        "type": "String",
        "value": "minecraft-logs"
      }
    },
    "parametersLink": null,
    "providers": [
      {
        "id": null,
        "namespace": "Microsoft.OperationalInsights",
        "providerAuthorizationConsentState": null,
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              "eastus2"
            ],
            "properties": null,
            "resourceType": "workspaces",
            "zoneMappings": null
          },
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              null
            ],
            "properties": null,
            "resourceType": "workspaces/tables",
            "zoneMappings": null
          }
        ]
      }
    ],
    "provisioningState": "Succeeded",
    "templateHash": "#######",
    "templateLink": null,
    "timestamp": "2025-04-10T20:08:53.833404+00:00",
    "validatedResources": null
  },
  "resourceGroup": "MinecraftRG",
  "tags": null,
  "type": "Microsoft.Resources/deployments"
}

```

