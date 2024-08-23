
# This script searches through the Exchange 365 Admin Center and pulls a list of all Distribution Groups and their current members.

$groups = @()
try {
    $groups = Get-DistributionGroup -ResultSize Unlimited -ErrorAction Stop
} catch {
    $errMsg = $_.Exception.Message
    if ($errMsg -like "*Ambiguous name resolution*") {
        Write-Warning "Error: Ambiguous name resolution. There are multiple distribution lists with the same name."
    } else {
        Write-Error "Error: $errMsg"
    }
}

$result = @()

foreach ($group in $groups) {
    try {
        $members = Get-DistributionGroupMember -Identity $group.Identity -ResultSize Unlimited -ErrorAction Stop
        foreach ($member in $members) {
            $result += [PSCustomObject]@{
                Group = $group.DisplayName
                Member = $member.Name
                EmailAddress = $member.PrimarySMTPAddress
                RecipientType = $member.RecipientType
            }
        }
    } catch {
        Write-Error "Error retrieving members for group $($group.DisplayName): $($_.Exception.Message)"
    }
}

$desktopPath = "C:\Users\ryoung\Desktop"
$result | Export-CSV -Path "$desktopPath\DistributionGroupMembers.csv" -NoTypeInformation -Encoding UTF8