# Get-Computer_UPS_Info.ps1

# Define the computer name
$computerName = "localhost"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Computer_UPS_Info.csv"

try {
    # Get the UPS information
    $upsInfo = Get-WmiObject -Class Win32_Battery -ComputerName $computerName -ErrorAction Stop

    # Output the results
    $upsInfo | Select-Object -Property DeviceID, EstimatedChargeRemaining, EstimatedRunTime

    # Export to CSV if specified
    if ($exportPath) {
        $upsInfo | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}