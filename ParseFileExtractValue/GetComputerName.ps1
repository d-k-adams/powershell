#	Author: 		oproot
#	Date:			May 9 2018
#	Description:	Reads text file, finds matching line, 
#					looks up IP address for computer name.
#	Requires:		Computer name and the incoming file path + name
#
Param(
  [string]$compName,
  [string]$inFile
)
try
{
	$regex = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\s+'
	$extract = @()
	select-string -path $inFile -pattern $regex -context 0,1 |
	foreach-object {
		If ($_.line -match $compName)
		{
			$extract += $_.Line.Replace("$compName","").Replace(" ","")
			Write-Host $extract
		}
	}
}
catch
{
	Write-Host ("Error")
	Write-Host ("StatusCode: " + $_.Exception.Response.StatusCode.value__)
	Write-Host ("StatusDescription: " + $_.Exception.Response.StatusDescription)
}
