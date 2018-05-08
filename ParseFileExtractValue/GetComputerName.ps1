
Param(
  [string]$compName,
  [string]$inFile
)
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

