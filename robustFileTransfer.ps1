# Source and destination directories
$sourceDir = "C:\Data"
$destDir = "Z:"

# log file path
$logFile = "C:\Scripts\file_transfer_logfile.log"

# Function to log messages
function Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $message"
}

# Log script start
Log "Transfer script started"

try {
    # Use Robocopy to transfer files
    robocopy $sourceDir $destDir /MOV /E /LOG:$logFile /NP /R:3 /W:5
    $exitCode = $LASTEXITCODE

    if ($exitCode -le 7) {
        Log "Files transferred successfully."
    } else {
        Log "Error during file transfer. Exit code: $exitCode"
    }

    # Clean up empty directories in the source directory
    Get-ChildItem $sourceDir -Recurse -Directory | Where-Object { $_.GetFileSystemInfos().Count -eq 0 } | Remove-Item
} catch {
    Log "Error: $_"
} finally {
    Log "Transfer script ended"
}
# Source and destination directories
$sourceDir = "C:\Data"
$destDir = "Z:"

# log file path
$logFile = "C:\Scripts\file_transfer_logfile.log"

# Function to log messages
function Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $message"
}

# Log script start
Log "Transfer script started"

try {
    # Use Robocopy to transfer files
    robocopy $sourceDir $destDir /MOV /E /LOG:$logFile /NP /R:3 /W:5
    $exitCode = $LASTEXITCODE

    if ($exitCode -le 7) {
        Log "Files transferred successfully."
    } else {
        Log "Error during file transfer. Exit code: $exitCode"
    }

    # Clean up empty directories in the source directory
    Get-ChildItem $sourceDir -Recurse -Directory | Where-Object { $_.GetFileSystemInfos().Count -eq 0 } | Remove-Item
} catch {
    Log "Error: $_"
} finally {
    Log "Transfer script ended"
}
