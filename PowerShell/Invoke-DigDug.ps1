<##################################################################################
	Invoke-DigDug / 1.1
	
   Copyright 2019 kemotep

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
	kemotep@gmail.com / https://github.com/kemotep/ 
###################################################################################
This is my take on FizzBuzz, or in this case DigDug. Load this using Import-Module.#>
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
