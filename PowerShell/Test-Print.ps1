<##################################################################################
	Test-Print / 1.1 
	
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
Test Powershell Script
Practice of creating variables, if/else, and various cmdlets
Here we create a variable named receiptName
Since it is based off of time down to the seconds, it can only be declared once
TODO: Better Handle Files for Logging
#>
function Test-Print {
New-Variable -Name "receiptName" `
	-Value "$( get-date -f yyyy-MM-dd-hh-mm-ss )-$env:UserName-Receipts.txt"
# Here is the meat and potatoes: if condition dig is true, then dug, else digdug.	
if ( Test-Path -Path "$env:userprofile\Documents\Receipts" ) {

        cd "$env:userprofile\Documents\Receipts"
		New-Item -Path . -Name "$receiptName" -ItemType "file" 
		Add-Content -Value ( Get-Content "Path\to\Test\Print\Content" ) `
		-Path "$env:userprofile\Documents\Receipts\$receiptName"		
		}		
else {
		cd "$env:userprofile\Documents"
		New-Item -Path . -Name "Receipts" -ItemType "directory"
		cd Receipts
		New-Item -Path . -Name "$receiptName" -ItemType "file" -Value
		Add-Content -Value ( Get-Content "Path\to\Test\Print\Content" ) `
		-Path "$env:userprofile\Documents\Receipts\$receiptName"		
		}
# Now we print via powershell to the Windows default printer!
# Here we are confirming the success of the script and giving us a delay before the printing.
echo "Now Printing $receiptName..."
cmd /c pause
$test = Get-Content -Path "$env:userprofile\Documents\Receipts\$receiptName"
Out-Printer -InputObject $test
}
