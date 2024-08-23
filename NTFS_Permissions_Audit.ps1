# Define the root directory to start the search
$rootDirectory = "C:\"
$csvFilePath = "$env:USERPROFILE\Desktop\SecurityPermissions.csv"

# Function to recursively get ACL information for files and folders
function Get-ACLInfo {
    param (
        [string]$path
    )

    try {
        # Retrieve ACL information for the current item
        $acl = Get-Acl -Path $path

        # Initialize an array to store ACL information
        $aclInfoArray = @()

        # Output access rules
        foreach ($accessRule in $acl.Access) {
            $aclInfo = [PSCustomObject]@{
                'Path' = $path
                'File/Folder Name' = (Split-Path -Path $path -Leaf)
                'Permissions' = $accessRule.FileSystemRights
                'User/Group' = $accessRule.IdentityReference
            }

            # Add ACL information to the array
            $aclInfoArray += $aclInfo
        }

        # Output ACL information array
        return $aclInfoArray
    }
    catch {
        Write-Host "Error accessing ACL for $path : $_" -ForegroundColor Yellow
        return $null
    }
}

# Create an empty array to store ACL information
$aclInfoAll = @()

# Recursive function to traverse directories
function Traverse-Directory {
    param (
        [string]$path
    )

    try {
        Write-Host "Processing directory: $path"

        # Get all items in the current directory
        $items = Get-ChildItem -Path $path -ErrorAction Stop

        # Process each item
        foreach ($item in $items) {
            # Check if the item is a directory
            if ($item.PSIsContainer) {
                # Output ACL information for the directory
                $aclInfo = Get-ACLInfo -path $item.FullName
                if ($aclInfo -ne $null) {
                    $aclInfoAll += $aclInfo
                    # Recursively call the function for subdirectories
                    Traverse-Directory -path $item.FullName
                }
            } else {
                # Output ACL information for the file
                $aclInfo = Get-ACLInfo -path $item.FullName
                if ($aclInfo -ne $null) {
                    $aclInfoAll += $aclInfo
                }
            }
        }
    }
    catch {
        Write-Host "Error accessing directory $path : $_" -ForegroundColor Yellow
    }
}

# Start the traversal from the root directory
Traverse-Directory -path $rootDirectory

# Export ACL information to CSV
$aclInfoAll | Export-Csv -Path $csvFilePath -NoTypeInformation
