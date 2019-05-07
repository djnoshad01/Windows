 <##################################################################################
	Get-UpTime / 1.1
	
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
Neat script from /r/sysadmin. Load this using Import-Module. #>
function Get-UpTime {
<#  
.Synopsis
    Get a given computers current uptime
.DESCRIPTION
    This function will allows a user to determine the uptime of a given computer using a wmi query. 
	Useful for determing last boot.
#>
param (
    [Parameter(mandatory = $true, ValueFromPipeline = $true)]
    [string]$ComputerName = @(".")
      )
process {
# Here we see if the computer responds to a ping, otherwise the WMI queries will fail
    $query = "select * from win32_pingstatus where address = '$ComputerName'"
    $ping = Get-WmiObject -query $query
    if ($ping.protocoladdress) {
        # Ping responded, so mow we connect to the computer via WMI
        $os = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName -ev myError -ea SilentlyContinue
        $LastBootUpTime = $os.ConvertToDateTime($os.LastBootUpTime)
        $LocalDateTime = $os.ConvertToDateTime($os.LocalDateTime)
        # Here we are calculating uptime
        $up = $LocalDateTime - $LastBootUpTime
        # Changing it to a more human readable format
        $uptime = "$($up.Days) days, $($up.Hours)h, $($up.Minutes)mins"
        # We need to save the results for this computer in an object
        $results = new-object psobject
        $results | add-member noteproperty LastBootUpTime $LastBootUpTime
        $results | add-member noteproperty ComputerName $os.csname
        $results | add-member noteproperty uptime $uptime
        # Now we can display the results
        $results | Select-Object ComputerName, LastBootUpTime, uptime
        }
    # Print an error message if it fails
	else {
    "$ComputerName did not respond."
		 }
	}
}
