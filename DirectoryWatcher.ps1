# Source directory to monitor and the path to main script
$sourceDir = "C:\Data"
$mainScript = "C:\Scripts\robustFileTransfer.ps1"
# Define the source directory to monitor and the path to your main script
# $sourceDir = "C:\path\to\local\directory"
# $mainScript = "C:\Scripts\TransferFiles.ps1"

# Function to log messages
function Log {
    param ([string]$message)
    $logFile = "C:\Scripts\logfile.log"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $message"
}

# Log start of the watcher script
Log "Directory watcher script started."

# Check if the source directory exists
if (-Not (Test-Path -Path $sourceDir)) {
    Log "Source directory does not exist: $sourceDir"
    exit
}

# Define the action to take when a new file is created
$action = {
    Log "New file detected: $($Event.SourceEventArgs.FullPath)"
    # Execute the main script
    & $using:mainScript
}

# Create the FileSystemWatcher object
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $sourceDir
$watcher.Filter = "*.*"
$watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite'

# Register the event handler and store the registration object in a variable
$registeredEvent = Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action

# Start monitoring
$watcher.EnableRaisingEvents = $true

# Log the state of the watcher
if ($watcher.EnableRaisingEvents -eq $true) {
    Log "FileSystemWatcher started successfully."
} else {
    Log "FileSystemWatcher failed to start."
    exit
}

# Function to clean up event registration (if needed)
function Cleanup {
    Unregister-Event -SubscriptionId $registeredEvent.Id
    Log "Event handler unregistered."
}

# Add a cleanup step to unregister the event when the script ends
Register-EngineEvent -SourceIdentifier "PowerShell.Exiting" -Action { Cleanup }

# Keep the script running
Log "Entering monitoring loop."
while ($true) { Start-Sleep -Seconds 5 }
