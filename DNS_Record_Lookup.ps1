# DNS_Record_Lookup.ps1

# Define the hostname or IP address
$hostnameOrIp = "example.com"

# Define the export path (optional)
$exportPath = "$env:USERPROFILE\Desktop\DNS_Record_Lookup.csv"

try {
    # Get the DNS record
    $dnsRecord = Resolve-DnsName -Name $hostnameOrIp -ErrorAction Stop

    # Output the results
    $dnsRecord | Select-Object -Property Name, IPAddress, RecordType

    # Export to CSV if specified
    if ($exportPath) {
        $dnsRecord | Export-Csv -Path $exportPath -NoTypeInformation
        Write-Host "Results exported to $exportPath"
    }
} catch {
    Write-Error "Error: $_"
}