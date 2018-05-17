#
#	Folder monitor - to write out a file with text if no file detected
#
#	Syntax: psmonitor.ps1 -folderToMonitor "C:\a" 
#							-intervalInSeconds 30 
#							-watchLengthInSeconds 120 
#							-outputPathFile "C:\a1"
#							-textEvent "$DO:SOMETHING,CURRENT"
#	Incoming parameters:
#	1. Folder path (folder that will be monitored)
#	2. Number seconds interval to check for activity, i.e. 30 seconds
#	3. Number seconds to watch, watch window length, i.e. 3600 seconds
#	4. Output path, unique filename (writes file when there is no file)
#	5. Text to write
#	
Param(
  [string]$folderToMonitor,
  [int]$intervalInSeconds,
  [int]$watchLengthInSeconds,
  [string]$outputPathFile,
  [string]$textEvent  
)
$filesDetected = "false"
$timeout = new-timespan -seconds $watchLengthInSeconds
$sw = [diagnostics.stopwatch]::StartNew()
while ($sw.elapsed -lt $timeout){
	if((Get-ChildItem $folderToMonitor -force | 
			Select-Object -First 1 | 
			Measure-Object).Count -ne 0)
	{
		$filesDetected = "true"
	}
	sleep $intervalInSeconds
}
if ($filesDetected -ne "true")
{
	#Folder is still empty, write event to to file
	[IO.File]::WriteAllText($outputPathFile, $textEvent)
}
