# Get-Subnet_Scan.ps1

# Define the subnet
$subnet = "192.168.1.0/24"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Subnet_Scan.csv"

try {
    # Get the devices on the subnet
    $devices = Get-NetNeighbor -AddressFamily IPv4 -Subnet $subnet -ErrorAction Stop

    # Output the results
    $devices | Select-Object -Property IPAddress, MACAddress, State

    # Export to CSV if specified
    if ($exportPath) {
        $devices | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}