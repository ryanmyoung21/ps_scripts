#Import the Active Directory module for getting all computers in the domain
Import-Module ActiveDirectory

#Function to get the logged on user and IP address of a computer
function Get-LoggedOnUserAndIP {
    param(
        [string]$computerName
    )
    #Get the IP address of the computer
    try {
        $ipAddress = (Test-Connection -ComputerName $computerName -Count 1 -Quiet -ErrorAction Stop).IPV4Address
    } catch {
        Write-Error "Failed to get IP address for $computerName. Error: $_"
        return $null
    }
    #Get the logged on user of the computer
    try {
        $loggedOnUser = (Get-WmiObject -Class win32_computersystem -ComputerName $computerName -ErrorAction Stop).UserName
    } catch {
        Write-Error "Failed to get logged on user for $computerName. Error: $_"
        return $null
    }
    #Return the IP address and logged on user
    return [PSCustomObject]@{
        ComputerName = $computerName
        IPAddress = $ipAddress
        LoggedOnUser = $loggedOnUser
    }
}

#Create a log file
$logFile = <input the filepath of the log file here>

#Get the list of computers to include in the results
$computerList = "CHP-","SYS-"

#Loop through all computers in the list and turn on the RPC service
foreach ($computer in $computerList) {
    $computerNames = Get-ADComputer -Filter "Name -like '$computer*'" | Select-Object -ExpandProperty Name
    foreach ($computerName in $computerNames) {
        #Turn on the RPC service
        Invoke-Command -ComputerName $computerName -ScriptBlock {
            Set-Service -Name RpcSs -StartupType Automatic -ErrorAction Stop
            Start-Service -Name RpcSs
        }
    }
}

#Loop through all computers in the list and get the logged on user and IP address
$results = foreach ($computer in $computerList) {
    $computerNames = Get-ADComputer -Filter "Name -like '$computer*'" | Select-Object -ExpandProperty Name
    foreach ($computerName in $computerNames) {
        $result = Get-LoggedOnUserAndIP -computerName $computerName
        if ($result -ne $null) {
            $result
        } else {
            Write-Warning "Failed to get information for $computerName."
        }
    }
}

#Loop through all computers in the list and turn off the RPC service
foreach ($computer in $computerList) {
    $computerNames = Get-ADComputer -Filter "Name -like '$computer*'" | Select-Object -ExpandProperty Name
    foreach ($computerName in $computerNames) {
        #Turn off the RPC service
        Invoke-Command -ComputerName $computerName -ScriptBlock {
            Stop-Service -Name RpcSs
            Set-Service -Name RpcSs -StartupType Disabled
        }
    }
}

#Output the results
$results | Format-Table -AutoSize -Property ComputerName, IPAddress, LoggedOnUser

#Save the results to a log file
$results | Export-Csv -Path $logFile -NoTypeInformation