# Network_Switch_Port_Mapper.ps1

# Define the switch IP address
$switchIp = "192.168.1.100"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Network_Switch_Port_Mapper.csv"

try {
    # Get the switch ports
    $ports = Get-SNMP -ComputerName $switchIp -Community "public" -OID ".1.3.6.1.2.1.17.7.1.2.2.1.2" -ErrorAction Stop

    # Output the results
    $ports | Select-Object -Property PortNumber, MacAddress, IPAddress

    # Export to CSV if specified
    if ($exportPath) {
        $ports | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}