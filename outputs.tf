# output "shareinfo" {
#   description = "Share info"
#   value       = azurerm_storage_share.main
# }

# output "storage_account_info" {
#   description = "Storage account info"
#   value       = azurerm_storage_account.main
# }

output "stringconnectWin" {
  value = <<EOT
$connectTestResult = Test-NetConnection -ComputerName ${azurerm_storage_account.main.primary_file_host} -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"${azurerm_storage_account.main.primary_file_host}`" /user:`"Azure\${azurerm_storage_account.main.name}`" /pass:`"${azurerm_storage_account.main.primary_access_key}`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\${azurerm_storage_account.main.primary_file_host}\${azurerm_storage_share.main.name}" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}
EOT
}