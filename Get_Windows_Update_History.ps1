# Get-Windows_Update_History.ps1

# Define the computer name
$computerName = "localhost"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Windows_Update_History.csv"

try {
    # Get the Windows update history
    $updateHistory = Get-WindowsUpdateLog -CHP-PC322 $computerName -ErrorAction Stop

    # Output the results
    $updateHistory | Select-Object -Property Date, KB, Title, Status

    # Export to CSV if specified
    if ($exportPath) {
        $updateHistory | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}