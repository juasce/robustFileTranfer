# Source directory to monitor and the path to main script
$sourceDir = "C:\Data"
$mainScript = "C:\Scripts\robustFileTransfer.ps1"

# Function to log messages
function Log {
    param ([string]$message)
    $logFile = "C:\Scripts\directory_watcher_logfile.log"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $message"
}

# Action to take when a new file is created
$action = {
    Log "New file detected: $($Event.SourceEventArgs.FullPath)"
    # Execute the main script
    & $using:mainScript
}

# FileSystemWatcher object created
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $sourceDir
$watcher.Filter = "*.*"
$watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite'

# Event handler registered
Register-ObjectEvent $watcher "Created" -Action $action

# Start monitoring
$watcher.EnableRaisingEvents = $true

# Keep the script running
while ($true) { Start-Sleep -Seconds 5 }
