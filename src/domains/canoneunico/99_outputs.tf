output "sshPassword" {
  #   value = azapi_resource_action.generate_sftp_user_password.output
  value = { for k, v in azapi_resource_action.generate_sftp_user_password : k => v.output }
}
