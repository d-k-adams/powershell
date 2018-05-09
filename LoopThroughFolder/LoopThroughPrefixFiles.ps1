#	Author: 		oproot
#	Date:			May 9 2018
#	Description:	Loop through all files in a folder and append
#					a prefix to each filename.
#	Requires:		File path to loop through, new prefix
#
Param(
  [string]$folderWithFiles,
  [string]$prefix
)
try
{
	$files = Get-ChildItem $folderWithFiles\*.*
	ForEach ($file in $files) {
		$fname = $file.name
		Rename-Item $file $folderWithFiles$prefix$fname
	}
}
catch
{
	Write-Host ("Looping through directory failed. Appending prefix to filename failed.")
}
