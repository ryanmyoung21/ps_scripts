Automated Enterprise Troubleshooting Tools:
This repository contains a collection of PowerShell projects designed to automate various enterprise-level troubleshooting tasks.

Projects:
1. Get_AD _Groups_By_User
This script retrieves a list of Active Directory groups associated with a specified user.

2. Current_User_And_Associated_Ip_On_Network
This script retrieves the current user and their associated IP address on the network.

3. Exchange_365_Distribution_Lists_And_Members
This script retrieves a list of Exchange 365 distribution lists and their members.

4. Get_Windows_Product_Key
This script retrieves the Windows product key from a local or remote machine.

5. Network_PC_Names_And_IP_Addresses
This script retrieves a list of PC names and their associated IP addresses on the network.

6. NTFS_Permissions_Audit
This script audits NTFS permissions on a specified folder or file.

7. System_Cleanup
This script runs a series of system cleanup tasks, including:

System File Checker (SFC)
Deployment Image Servicing and Management (DISM)
Disk Cleanup
Optimize-Volume
Check Disk (chkdsk /r)

8. Get_Open_Files_On_Network_Share: Retrieves a list of open files on a network share, including the user and computer accessing the file.

9. Network_Printer_Inventory: Collects information about network printers, including their IP addresses, models, and current status.

10. Get_Computer_UPS_Info: Retrieves information about Uninterruptible Power Supplies (UPS) connected to computers on the network, including battery life and status.

11. DNS_Record_Lookup: Performs DNS lookups for specified hostnames or IP addresses, returning information about the associated DNS records.

12. Get_Subnet_Scan: Scans a specified subnet for active devices, returning their IP addresses, MAC addresses, and other relevant information.

13. Network_Switch_Port_Mapper: Maps network switch ports to connected devices, including their IP addresses and MAC addresses.

14. Get_Windows_Update_History: Retrieves a history of Windows updates applied to a local or remote machine, including the update name, installation date, and status.

15. Get_Computer_BIOS_Info: Retrieves information about the BIOS on a local or remote machine, including the BIOS version, manufacturer, and release date.


Usage:
Each project is a standalone PowerShell script. To use, simply edit the parameters in the file, run the script in PowerShell, and follow the prompts.

Requirements:
PowerShell 3.0 or later
Active Directory module (for Get_AD_Groups_By_User and NTFS_Permissions_Audit)
Exchange Online module (for Exchange_365_Distribution_Lists_And_Members)
Local administrator privileges (for System_Cleanup)


Contributing
If you'd like to contribute to these projects or suggest new features, please submit a pull request or open an issue.
