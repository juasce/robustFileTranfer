# Define the source and destination directories
$sourceDir = "C:\Data"
$destDir = "Z:"
# $destDir = "\\path\to\mounted\file\share"

# Define the log file path
$logFile = "C:\Program Files\FileZilla Server\Logs\robustFileTranfer"

# Run Robocopy to transfer files
robocopy $sourceDir $destDir /MOV /E /LOG:$logFile /NP /R:3 /W:5

# Check the exit code of Robocopy
$exitCode = $LASTEXITCODE

if ($exitCode -le 7) {
    Write-Output "Files transferred successfully."
    # Optionally, you can log the success
    Add-Content -Path $logFile -Value "Files transferred successfully at $(Get-Date)."
} else {
    Write-Output "Error during file transfer. Exit code: $exitCode"
    # Optionally, you can log the error
    Add-Content -Path $logFile -Value "Error during file transfer at $(Get-Date). Exit code: $exitCode"
}

# Optional: Clean up empty directories in the source directory
Get-ChildItem $sourceDir -Recurse -Directory | Where-Object { $_.GetFileSystemInfos().Count -eq 0 } | Remove-Item
