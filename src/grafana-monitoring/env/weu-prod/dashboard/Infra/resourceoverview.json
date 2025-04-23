{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "grafana",
          "uid": "-- Grafana --"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "description": "The dashboard provides insights of Azure Resource Graph Explorer overview, compute, Paas, networking, monitoring and security. Queries used in this Azure Monitor dashboard we sourced from the [Azure Inventory Workbook](https://github.com/scautomation/Azure-Inventory-Workbook) by Billy York. You can find more sample Azure Resource Graph queries by Billy at this [GitHub](https://github.com/scautomation/AzureResourceGraph-Examples) repository.",
  "editable": true,
  "fiscalYearStartMonth": 0,
  "gnetId": 14986,
  "graphTooltip": 0,
  "id": 386,
  "links": [
    {
      "asDropdown": false,
      "icon": "external link",
      "includeVars": false,
      "keepTime": false,
      "tags": [],
      "targetBlank": true,
      "title": "Azure Resource Graph queries by Billy York",
      "tooltip": "See more",
      "type": "link",
      "url": "https://github.com/scautomation/AzureResourceGraph-Examples"
    }
  ],
  "liveNow": false,
  "panels": [
    {
      "collapsed": false,
      "datasource": {
        "type": "datasource",
        "uid": "grafana"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 4,
      "panels": [],
      "targets": [
        {
          "datasource": {
            "type": "datasource",
            "uid": "grafana"
          },
          "refId": "A"
        }
      ],
      "title": "Overview",
      "type": "row"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 3,
        "x": 0,
        "y": 1
      },
      "id": 2,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "Resources | summarize count(type)",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Count of All Resources",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 21,
        "x": 3,
        "y": 1
      },
      "id": 55,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.insights/'\r\n     or type has 'microsoft.alertsmanagement/smartdetectoralertrules'\r\n     or type has 'microsoft.portal/dashboards'\r\n| where type != 'microsoft.insights/components'\r\n| extend type = case(\r\n \ttype == 'microsoft.insights/workbooks', \"Workbooks\",\r\n\ttype == 'microsoft.insights/activitylogalerts', \"Activity Log Alerts\",\r\n\ttype == 'microsoft.insights/scheduledqueryrules', \"Log Search Alerts\",\r\n\ttype == 'microsoft.insights/actiongroups', \"Action Groups\",\r\n\ttype == 'microsoft.insights/metricalerts', \"Metric Alerts\",\r\n\ttype =~ 'microsoft.alertsmanagement/smartdetectoralertrules','Smart Detection Rules',\r\n    type =~ 'microsoft.insights/webtests', 'URL Web Tests',\r\n    type =~ 'microsoft.portal/dashboards', 'Portal Dashboards',\r\n    type =~ 'microsoft.insights/datacollectionrules', 'Data Collection Rules',\r\n    type =~ 'microsoft.insights/autoscalesettings', 'Auto Scale Settings',\r\n    type =~ 'microsoft.insights/alertrules', 'Alert Rules',\r\nstrcat(\"Not Translated: \", type))\r\n| summarize count() by type",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Azure Monitor Workbooks & Alerting Resources",
      "type": "stat"
    },
    {
      "collapsed": false,
      "datasource": {
        "type": "datasource",
        "uid": "grafana"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 4
      },
      "id": 10,
      "panels": [],
      "targets": [
        {
          "datasource": {
            "type": "datasource",
            "uid": "grafana"
          },
          "refId": "A"
        }
      ],
      "title": "Compute",
      "type": "row"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 6,
        "w": 24,
        "x": 0,
        "y": 5
      },
      "id": 13,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "Resources | where type =~ \"microsoft.compute/virtualmachines\"\r\nor type =~ 'microsoft.compute/virtualmachinescalesets'\r\n| extend Size = case(\r\ntype contains 'microsoft.compute/virtualmachinescalesets', strcat(\"VMSS \", sku.name),\r\ntype contains 'microsoft.compute/virtualmachines', properties.hardwareProfile.vmSize,\r\n\"Size not found\")\r\n| summarize Count=count(Size) by vmSize=tostring(Size)",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Count of VMs by VM Size",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "OverProvision"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 141
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "location"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 90
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "Size"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 154
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "Capacity"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 118
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "OSType"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 115
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "UpgradeMode"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 157
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "resourceGroup"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 281
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 4,
        "w": 24,
        "x": 0,
        "y": 11
      },
      "id": 15,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true,
        "sortBy": []
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources \r\n| where type has 'microsoft.compute/virtualmachinescalesets'\r\n| extend Size = sku.name\r\n| extend Capacity = sku.capacity\r\n| extend UpgradeMode = properties.upgradePolicy.mode\r\n| extend OSType = properties.virtualMachineProfile.storageProfile.osDisk.osType\r\n| extend OS = properties.virtualMachineProfile.storageProfile.imageReference.offer\r\n| extend OSVersion = properties.virtualMachineProfile.storageProfile.imageReference.sku\r\n| extend OverProvision = properties.overprovision\r\n| extend ZoneBalance = properties.zoneBalance\r\n| extend Details = pack_all()\r\n| project VMSS = id, location, resourceGroup, subscriptionId, Size, Capacity, OSType, UpgradeMode, OverProvision, Details",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "VM Scale Sets",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 24,
        "x": 0,
        "y": 15
      },
      "id": 21,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "Resources  \r\n| where type contains \"microsoft.compute/disks\" \r\n| extend diskState = tostring(properties.diskState)\r\n| where managedBy == \"\"\r\n    or diskState == 'Unattached'\r\n| project id, diskState, resourceGroup, location, subscriptionId",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Orphaned Disks",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 5,
        "w": 24,
        "x": 0,
        "y": 18
      },
      "id": 20,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type =~ \"microsoft.network/networkinterfaces\"\r\n| join kind=leftouter (resources\r\n| where type =~ 'microsoft.network/privateendpoints'\r\n| extend nic = todynamic(properties.networkInterfaces)\r\n| mv-expand nic\r\n| project id=tostring(nic.id) ) on id\r\n| where isempty(id1)\r\n| where properties !has 'virtualmachine'\r\n| project id, resourceGroup, location, subscriptionId",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Orphaned NICs",
      "type": "table"
    },
    {
      "collapsed": false,
      "datasource": {
        "type": "datasource",
        "uid": "grafana"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 23
      },
      "id": 23,
      "panels": [],
      "targets": [
        {
          "datasource": {
            "type": "datasource",
            "uid": "grafana"
          },
          "refId": "A"
        }
      ],
      "title": "PaaS",
      "type": "row"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 6,
        "x": 0,
        "y": 24
      },
      "id": 28,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.web'\r\n\t or type =~ 'microsoft.apimanagement/service'\r\n\t or type =~ 'microsoft.network/frontdoors'\r\n\t or type =~ 'microsoft.network/applicationgateways'\r\n\t or type =~ 'microsoft.appconfiguration/configurationstores'\r\n| extend type = case(\r\n\ttype == 'microsoft.web/serverfarms', \"App Service Plans\",\r\n\tkind == 'functionapp', \"Azure Functions\", \r\n\tkind == \"api\", \"API Apps\", \r\n\ttype == 'microsoft.web/sites', \"App Services\",\r\n\ttype =~ 'microsoft.network/applicationgateways', 'App Gateways',\r\n\ttype =~ 'microsoft.network/frontdoors', 'Front Door',\r\n\ttype =~ 'microsoft.apimanagement/service', 'API Management',\r\n\ttype =~ 'microsoft.web/certificates', 'App Certificates',\r\n\ttype =~ 'microsoft.appconfiguration/configurationstores', 'App Config Stores',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Apps Overview",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 18,
        "x": 6,
        "y": 24
      },
      "id": 29,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true,
        "sortBy": [
          {
            "desc": false,
            "displayName": "Sku"
          }
        ]
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.web'\r\n\t or type =~ 'microsoft.apimanagement/service'\r\n\t or type =~ 'microsoft.network/frontdoors'\r\n\t or type =~ 'microsoft.network/applicationgateways'\r\n\t or type =~ 'microsoft.appconfiguration/configurationstores'\r\n| extend type = case(\r\n\ttype == 'microsoft.web/serverfarms', \"App Service Plans\",\r\n\tkind == 'functionapp', \"Azure Functions\", \r\n\tkind == \"api\", \"API Apps\", \r\n\ttype == 'microsoft.web/sites', \"App Services\",\r\n\ttype =~ 'microsoft.network/applicationgateways', 'App Gateways',\r\n\ttype =~ 'microsoft.network/frontdoors', 'Front Door',\r\n\ttype =~ 'microsoft.apimanagement/service', 'API Management',\r\n\ttype =~ 'microsoft.web/certificates', 'App Certificates',\r\n\ttype =~ 'microsoft.appconfiguration/configurationstores', 'App Config Stores',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Sku = case(\r\n\ttype =~ 'App Gateways', properties.sku.name, \r\n\ttype =~ 'Azure Functions', properties.sku,\r\n\ttype =~ 'API Management', sku.name,\r\n\ttype =~ 'App Service Plans', sku.name,\r\n\ttype =~ 'App Services', properties.sku,\r\n\ttype =~ 'App Config Stores', sku.name,\r\n\t' ')\r\n| extend State = case(\r\n\ttype =~ 'App Config Stores', properties.provisioningState,\r\n\ttype =~ 'App Service Plans', properties.status,\r\n\ttype =~ 'Azure Functions', properties.enabled,\r\n\ttype =~ 'App Services', properties.state,\r\n\ttype =~ 'API Management', properties.provisioningState,\r\n\ttype =~ 'App Gateways', properties.provisioningState,\r\n\ttype =~ 'Front Door', properties.provisioningState,\r\n\t' ')\r\n| mv-expand publicIpId=properties.frontendIPConfigurations\r\n| mv-expand publicIpId = publicIpId.properties.publicIPAddress.id\r\n| extend publicIpId = tostring(publicIpId)\r\n\t| join kind=leftouter(\r\n\t  \tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project publicIpId = id, publicIpAddress = tostring(properties.ipAddress)) on publicIpId\r\n| extend PublicIP = case(\r\n\ttype =~ 'API Management', properties.publicIPAddresses,\r\n\ttype =~ 'App Gateways', publicIpAddress,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, type, subscriptionId, Sku, State, PublicIP, Details",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Apps Detailed View",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 6,
        "x": 0,
        "y": 34
      },
      "id": 30,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.servicebus'\r\n\tor type has 'microsoft.eventhub'\r\n\tor type has 'microsoft.eventgrid'\r\n\tor type has 'microsoft.relay'\r\n| extend type = case(\r\n\ttype == 'microsoft.eventgrid/systemtopics', \"EventGrid System Topics\",\r\n\ttype =~ \"microsoft.eventgrid/topics\", \"EventGrid Topics\",\r\n\ttype =~ 'microsoft.eventhub/namespaces', \"EventHub Namespaces\",\r\n\ttype =~ 'microsoft.servicebus/namespaces', 'ServiceBus Namespaces',\r\n\ttype =~ 'microsoft.relay/namespaces', 'Relays',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Events Overview",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 18,
        "x": 6,
        "y": 34
      },
      "id": 31,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true,
        "sortBy": []
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.servicebus'\r\n\tor type has 'microsoft.eventhub'\r\n\tor type has 'microsoft.eventgrid'\r\n\tor type has 'microsoft.relay'\r\n| extend type = case(\r\n\ttype == 'microsoft.eventgrid/systemtopics', \"EventGrid System Topics\",\r\n\ttype =~ \"microsoft.eventgrid/topics\", \"EventGrid Topics\",\r\n\ttype =~ 'microsoft.eventhub/namespaces', \"EventHub Namespaces\",\r\n\ttype =~ 'microsoft.servicebus/namespaces', 'ServiceBus Namespaces',\r\n\ttype =~ 'microsoft.relay/namespaces', 'Relays',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Sku = case(\r\n\ttype =~ 'Relays', sku.name, \r\n\ttype =~ 'EventGrid System Topics', properties.sku,\r\n\ttype =~ 'EventGrid Topics', sku.name,\r\n\ttype =~ 'EventHub Namespaces', sku.name,\r\n\ttype =~ 'ServiceBus Namespaces', sku.sku,\r\n\t' ')\r\n| extend Endpoint = case(\r\n\ttype =~ 'Relays', properties.serviceBusEndpoint,\r\n\ttype =~ 'EventGrid Topics', properties.endpoint,\r\n\ttype =~ 'EventHub Namespaces', properties.serviceBusEndpoint,\r\n\ttype =~ 'ServiceBus Namespaces', properties.serviceBusEndpoint,\r\n\t' ')\r\n| extend Status = case(\r\n\ttype =~ 'Relays', properties.provisioningState,\r\n\ttype =~ 'EventGrid System Topics', properties.provisioningState,\r\n\ttype =~ 'EventGrid Topics', properties.publicNetworkAccess,\r\n\ttype =~ 'EventHub Namespaces', properties.status,\r\n\ttype =~ 'ServiceBus Namespaces', properties.status,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, type, subscriptionId, resourceGroup, Sku, Status, Endpoint, Details",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Events Detailed View",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 6,
        "x": 0,
        "y": 44
      },
      "id": 32,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources \r\n| where type has 'microsoft.documentdb'\r\n\tor type has 'microsoft.sql'\r\n\tor type has 'microsoft.dbformysql'\r\n\tor type has 'microsoft.sql'\r\n    or type has 'microsoft.purview'\r\n    or type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.analysisservices'\r\n\tor type has 'microsoft.datamigration'\r\n\tor type has 'microsoft.synapse'\r\n\tor type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.kusto'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB',\r\n\ttype =~ 'microsoft.sql/servers/databases', 'SQL DBs',\r\n\ttype =~ 'microsoft.dbformysql/servers', 'MySQL',\r\n\ttype =~ 'microsoft.sql/servers', 'SQL Servers',\r\n    type =~ 'microsoft.purview/accounts', 'Purview Accounts',\r\n\ttype =~ 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\n\ttype =~ 'microsoft.kusto/clusters', 'ADX Clusters',\r\n\ttype =~ 'microsoft.datafactory/factories', 'Data Factories',\r\n\ttype =~ 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\n\ttype =~ 'microsoft.analysisservices/servers', 'Analysis Services Servers',\r\n\ttype =~ 'microsoft.datamigration/services', 'DB Migration Service',\r\n\ttype =~ 'microsoft.sql/managedinstances/databases', 'Managed Instance DBs',\r\n\ttype =~ 'microsoft.sql/managedinstances', 'Managed Instnace',\r\n\ttype =~ 'microsoft.datamigration/services/projects', 'Data Migration Projects',\r\n\ttype =~ 'microsoft.sql/virtualclusters', 'SQL Virtual Clusters',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Data Overview",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "left",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 18,
        "x": 6,
        "y": 44
      },
      "id": 33,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources \r\n| where type has 'microsoft.documentdb'\r\n\tor type has 'microsoft.sql'\r\n\tor type has 'microsoft.dbformysql'\r\n\tor type has 'microsoft.sql'\r\n    or type has 'microsoft.purview'\r\n    or type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.analysisservices'\r\n\tor type has 'microsoft.datamigration'\r\n\tor type has 'microsoft.synapse'\r\n\tor type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.kusto'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB',\r\n\ttype =~ 'microsoft.sql/servers/databases', 'SQL DBs',\r\n\ttype =~ 'microsoft.dbformysql/servers', 'MySQL',\r\n\ttype =~ 'microsoft.sql/servers', 'SQL Servers',\r\n    type =~ 'microsoft.purview/accounts', 'Purview Accounts',\r\n\ttype =~ 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\n\ttype =~ 'microsoft.kusto/clusters', 'ADX Clusters',\r\n\ttype =~ 'microsoft.datafactory/factories', 'Data Factories',\r\n\ttype =~ 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\n\ttype =~ 'microsoft.analysisservices/servers', 'Analysis Services Servers',\r\n\ttype =~ 'microsoft.datamigration/services', 'DB Migration Service',\r\n\ttype =~ 'microsoft.sql/managedinstances/databases', 'Managed Instance DBs',\r\n\ttype =~ 'microsoft.sql/managedinstances', 'Managed Instnace',\r\n\ttype =~ 'microsoft.datamigration/services/projects', 'Data Migration Projects',\r\n\ttype =~ 'microsoft.sql/virtualclusters', 'SQL Virtual Clusters',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Sku = case(\r\n\ttype =~ 'CosmosDB', properties.databaseAccountOfferType,\r\n\ttype =~ 'SQL DBs', sku.name,\r\n\ttype =~ 'MySQL', sku.name,\r\n\ttype =~ 'ADX Clusters', sku.name,\r\n\ttype =~ 'Purview Accounts', sku.name,\r\n\t' ')\r\n| extend Status = case(\r\n\ttype =~ 'CosmosDB', properties.provisioningState,\r\n\ttype =~ 'SQL DBs', properties.status,\r\n\ttype =~ 'MySQL', properties.userVisibleState,\r\n\ttype =~ 'Managed Instance DBs', properties.status,\r\n\t' ')\r\n| extend Endpoint = case(\r\n\ttype =~ 'MySQL', properties.fullyQualifiedDomainName,\r\n\ttype =~ 'SQL Servers', properties.fullyQualifiedDomainName,\r\n\ttype =~ 'CosmosDB', properties.documentEndpoint,\r\n\ttype =~ 'ADX Clusters', properties.uri,\r\n\ttype =~ 'Purview Accounts', properties.endpoints,\r\n\ttype =~ 'Synapse Workspaces', properties.connectivityEndpoints,\r\n\ttype =~ 'Synapse SQL Pools', sku.name,\r\n\t' ')\r\n| extend Tier = sku.tier\r\n| extend License = properties.licenseType\r\n| extend maxSizeGB = todouble(case(\r\n\ttype =~ 'SQL DBs', properties.maxSizeBytes,\r\n\ttype =~ 'MySQL', properties.storageProfile.storageMB,\r\n\ttype =~ 'Synapse SQL Pools', properties.maxSizeBytes,\r\n\t' '))\r\n| extend maxSizeGB = case(\r\n\t\ttype has 'SQL DBs', maxSizeGB /1000 /1000 /1000,\r\n\t\ttype has 'Synapse SQL Pools', maxSizeGB /1000 /1000 /1000,\r\n\t\ttype has 'MySQL', maxSizeGB /1000,\r\n\t\tmaxSizeGB)\r\n| extend Details = pack_all()\r\n| project Resource=id, resourceGroup, subscriptionId, type, Sku, Tier, Status, Endpoint, maxSizeGB, Details\r\n",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Data Detailed View",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 6,
        "x": 0,
        "y": 54
      },
      "id": 34,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources \r\n| where type =~ 'microsoft.storagesync/storagesyncservices'\r\n\tor type =~ 'microsoft.recoveryservices/vaults'\r\n\tor type =~ 'microsoft.storage/storageaccounts'\r\n\tor type =~ 'microsoft.keyvault/vaults'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\n\ttype =~ 'microsoft.recoveryservices/vaults', 'Azure Backup',\r\n\ttype =~ 'microsoft.storage/storageaccounts', 'Storage Accounts',\r\n\ttype =~ 'microsoft.keyvault/vaults', 'Key Vaults',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Storage and Backup Overview",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 18,
        "x": 6,
        "y": 54
      },
      "id": 35,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources \r\n| where type =~ 'microsoft.storagesync/storagesyncservices'\r\n\tor type =~ 'microsoft.recoveryservices/vaults'\r\n\tor type =~ 'microsoft.storage/storageaccounts'\r\n\tor type =~ 'microsoft.keyvault/vaults'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\n\ttype =~ 'microsoft.recoveryservices/vaults', 'Azure Backup',\r\n\ttype =~ 'microsoft.storage/storageaccounts', 'Storage Accounts',\r\n\ttype =~ 'microsoft.keyvault/vaults', 'Key Vaults',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Sku = case(\r\n\ttype !has 'Key Vaults', sku.name,\r\n\ttype =~ 'Key Vaults', properties.sku.name,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, type, kind, subscriptionId, resourceGroup, Sku, Details",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Storage and Backup Detailed View",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 6,
        "x": 0,
        "y": 64
      },
      "id": 36,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type =~ 'microsoft.containerservice/managedclusters'\r\n\tor type =~ 'microsoft.containerregistry/registries'\r\n\tor type =~ 'microsoft.containerinstance/containergroups'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.containerservice/managedclusters', 'AKS',\r\n\ttype =~ 'microsoft.containerregistry/registries', 'Container Registry',\r\n\ttype =~ 'microsoft.containerinstance/containergroups', 'Container Instnaces',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type\t",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Containers Overview",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 18,
        "x": 6,
        "y": 64
      },
      "id": 37,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type =~ 'microsoft.containerservice/managedclusters'\r\n\tor type =~ 'microsoft.containerregistry/registries'\r\n\tor type =~ 'microsoft.containerinstance/containergroups'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.containerservice/managedclusters', 'AKS',\r\n\ttype =~ 'microsoft.containerregistry/registries', 'Container Registry',\r\n\ttype =~ 'microsoft.containerinstance/containergroups', 'Container Instnaces',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Tier = sku.tier\r\n| extend sku = sku.name\r\n| extend State = case(\r\n\ttype =~ 'Container Registry', properties.provisioningState,\r\n\ttype =~ 'Container Instance', properties.instanceView.state,\r\n\tproperties.powerState.code)\r\n| extend Containers = properties.containers\r\n| mvexpand Containers\r\n| extend RestartCount = Containers.properties.instanceView.restartCount\r\n| extend Image = Containers.properties.image\r\n| extend RestartPolicy = properties.restartPolicy\r\n| extend IP = properties.ipAddress.ip\r\n| extend Version = properties.kubernetesVersion\r\n| extend AgentProfiles = properties.agentPoolProfiles\r\n| mvexpand AgentProfiles\r\n| extend NodeCount = AgentProfiles.[\"count\"]\r\n| extend Details = pack_all()\r\n| project id, type, location, resourceGroup, subscriptionId, sku, Tier, State, RestartCount, Version, NodeCount, Details",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Containers Detailed View",
      "type": "table"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 6,
        "x": 0,
        "y": 74
      },
      "id": 42,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "percentChangeColorMode": "standard",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": true
        },
        "showPercentChange": false,
        "text": {},
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.desktopvirtualization'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.desktopvirtualization/applicationgroups', 'WVD App Groups',\r\n\ttype =~ 'microsoft.desktopvirtualization/hostpools', 'WVD Host Pools',\r\n\ttype =~ 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Windows Virtual Desktop Overview",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${ds}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 18,
        "x": 6,
        "y": 74
      },
      "id": 43,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "11.2.2+security-01",
      "targets": [
        {
          "account": "",
          "azureResourceGraph": {
            "query": "resources\r\n| where type has 'microsoft.desktopvirtualization'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.desktopvirtualization/applicationgroups', 'WVD App Groups',\r\n\ttype =~ 'microsoft.desktopvirtualization/hostpools', 'WVD Host Pools',\r\n\ttype =~ 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Details = pack_all()\r\n| project id, type, resourceGroup, subscriptionId, kind, location, Details",
            "resultFormat": "table"
          },
          "backends": [],
          "datasource": {
            "uid": "${ds}"
          },
          "dimension": "",
          "environment": "prod",
          "metric": "",
          "namespace": "",
          "queryType": "Azure Resource Graph",
          "refId": "A",
          "samplingType": "",
          "service": "metric",
          "subscriptions": [
            "$subscriprions"
          ],
          "useBackends": false,
          "useCustomSeriesNaming": false
        }
      ],
      "title": "Windows Virtual Desktop Detailed View",
      "type": "table"
    }
  ],
  "refresh": "",
  "schemaVersion": 39,
  "tags": [],
  "templating": {
    "list": [
      {
        "current": {
          "selected": false,
          "text": "Azure Monitor",
          "value": "azure-monitor-oob"
        },
        "hide": 0,
        "includeAll": false,
        "label": "Datasource",
        "multi": false,
        "name": "ds",
        "options": [],
        "query": "grafana-azure-monitor-datasource",
        "queryValue": "",
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "type": "datasource"
      },
      {
        "current": {
          "selected": false,
          "text": "DEV-pagoPA",
          "value": "bbe47ad4-08b3-4925-94c5-1278e5819b86"
        },
        "datasource": {
          "uid": "${ds}"
        },
        "definition": "Subscriptions()",
        "hide": 0,
        "includeAll": false,
        "label": "Subscription(s)",
        "multi": true,
        "name": "subscriprions",
        "options": [],
        "query": "Subscriptions()",
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "sort": 5,
        "type": "query"
      }
    ]
  },
  "time": {
    "from": "now-1h",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Resources SKU & Tier Overview",
  "uid": "Mtwt2BV7k2",
  "weekStart": ""
}