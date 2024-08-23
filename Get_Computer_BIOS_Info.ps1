# Get-Computer_BIOS_Info.ps1

# Define the computer name
$computerName = "localhost"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Computer_BIOS_Info.csv"

try {
    # Get the BIOS information
    $biosInfo = Get-WmiObject -Class Win32_BIOS -ComputerName $computerName -ErrorAction Stop

    # Output the results
    $biosInfo | Select-Object -Property Manufacturer, Model, Version, SerialNumber

    # Export to CSV if specified
    if ($exportPath) {
        $biosInfo | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}