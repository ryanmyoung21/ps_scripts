# Network_Printer_Inventory.ps1

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Network_Printer_Inventory.csv"

try {
    # Get the list of printers on the network
    $printers = Get-Printer -ComputerName (Get-ADComputer -Filter *).Name -ErrorAction Stop

    # Output the results
    $printers | Select-Object -Property Name, ComputerName, Model, Status

    # Export to CSV if specified
    if ($exportPath) {
        $printers | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}