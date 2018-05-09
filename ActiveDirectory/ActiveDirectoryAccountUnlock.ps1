#	Author: 		oproot
#	Date:			May 9 2018
#	Description:	Accepts username and unlocks Active Directory account
#	Requires:		Username
#
Param(
  [string]$adname
)
try
{
	Unlock-ADAccount -Identity $adname
}
catch
{
	Write-Host ("Unlock AD Account failed.")
}
