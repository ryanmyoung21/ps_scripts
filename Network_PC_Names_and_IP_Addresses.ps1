#Get the list of computers to include in the results
$computerList = "<Computer name list here, eg. CHP- or SYS->"

#Create a log file
$logFile = <Input file path for the log file here>

#Loop through all computers in the list and get the IP address
$results = foreach ($computer in $computerList) {
    $computerNames = Get-ADComputer -Filter "Name -like '$computer*'" | Select-Object -ExpandProperty Name
    foreach ($computerName in $computerNames) {
        #Test the connection to the remote computer
        $ipAddress = Test-Connection -ComputerName $computerName -Count 1 -Quiet -ErrorAction SilentlyContinue
        if ($ipAddress -eq $true) {
            #Get the computer name
            $computerName = $computerName.ToUpper()
            #Return the computer name and IP address
            [PSCustomObject]@{
                ComputerName = $computerName
                IPAddress = (Test-Connection -ComputerName $computerName -Count 1 -Quiet -ErrorAction SilentlyContinue).IPV4Address
            }
        } else {
            Write-Warning "Failed to get information for $computerName. The computer may be offline or unreachable."
        }
    }
}

#Output the results
$results | Format-Table -AutoSize -Property ComputerName, IPAddress

#Save the results to a log file
$results | Export-Csv -Path $logFile -NoTypeInformation