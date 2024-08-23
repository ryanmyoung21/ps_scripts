# Get-Open_Files_On_Network_Share.ps1

# Define the network share path
$sharePath = "\\server\share"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\Open_Files_On_Network_Share.csv"

try {
    # Get the open files on the network share
    $openFiles = Get-SmbOpenFile -Path $sharePath -ErrorAction Stop

    # Output the results
    $openFiles | Select-Object -Property ClientComputerName, ClientUserName, FileName, FileId

    # Export to CSV if specified
    if ($exportPath) {
        $openFiles | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}