<# 
###################################################################################
	Invoke-DigDug / 1.0.0
	kemotep
	2019-04-20 / GNU Lesser General Public License v3
	kemotep@gmail.com / https://github.com/kemotep/ 
###################################################################################
This is my take on FizzBuzz, or in this case DigDug. Load this using Import-Module.
#>
function Invoke-DigDug { 
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false, Position = 0)]
		$Min = 1,

	[Parameter(Mandatory = $false, Position = 1)]
		$Max = 100
	)
	for ($X = $Min; $X -le $Max; $X++) {
		$Output = ""
		if ($X % 3 -eq 0) { $Output += "Dig" }
		if ($X % 5 -eq 0) { $Output += "Dug" }
		if ($Output -eq "") { $Output = $X }
		Write-Output $Output
	}
}