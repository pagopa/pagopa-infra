{
  "fileUris": [
    "file://C:\\tmp\\host_pool_join.ps1"
  ],
  "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File C:\\tmp\\host_pool_join.ps1 -hostPoolName ${host_pool_name} -registrationToken ${registration_token} -vmName ${vm_name} -resourceGroupName ${rg_name}"
}
