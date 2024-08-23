# Run SFC command
$SFC_Command = "SFC /scannow"
Write-Host "Running SFC command: $SFC_Command"
Start-Process -FilePath powershell.exe -ArgumentList "-Command $SFC_Command" -Wait -NoNewWindow

# Run DISM command
$DISM_Command = "DISM /Online /Cleanup-Image /RestoreHealth"
Write-Host "Running DISM command: $DISM_Command"
Start-Process -FilePath powershell.exe -ArgumentList "-Command $DISM_Command" -Wait -NoNewWindow

# Run Disk Cleanup tool
$DiskCleanup_Command = "Cleanmgr.exe /sagerun:1"
Write-Host "Running Disk Cleanup tool: $DiskCleanup_Command"
Start-Process -FilePath cmd.exe -ArgumentList "/c $DiskCleanup_Command" -Wait -NoNewWindow

# Run Optimize-Volume command
$OptimizeVolume_Command = "Optimize-Volume -DriveLetter C -Retrim -Defrag -SlabConsolidate"
Write-Host "Running Optimize-Volume command: $OptimizeVolume_Command"
Start-Process -FilePath powershell.exe -ArgumentList "-Command $OptimizeVolume_Command" -Wait -NoNewWindow

# Run CHKDSK /r command
$CHKDSK_Command = "chkdsk C: /r"
Write-Host "Running CHKDSK command: $CHKDSK_Command"
Start-Process -FilePath cmd.exe -ArgumentList "/c $CHKDSK_Command" -Wait -NoNewWindow