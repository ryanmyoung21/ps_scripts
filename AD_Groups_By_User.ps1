# Prompt user to enter UPN (User Principal Name)
$upn = Read-Host -Prompt "Enter user's UPN (e.g., user@example.com)"

# Try to retrieve the user from Active Directory
try {
    $user = Get-ADUser -Filter { UserPrincipalName -eq $upn } -Properties MemberOf
    if ($user) {
        # Get the groups the user is a member of
        $groups = $user.MemberOf | ForEach-Object { (Get-ADGroup $_).Name }

        # Display the groups
        Write-Host "User '$upn' is a member of the following groups:"
        $groups

        # Copy the groups to clipboard
        $groups -join "`r`n" | Set-Clipboard
        Write-Host "Group names copied to clipboard."
    } else {
        Write-Host "User with UPN '$upn' not found in Active Directory." -ForegroundColor Red
    }
} catch {
    Write-Host "Error occurred: $_" -ForegroundColor Red
}
