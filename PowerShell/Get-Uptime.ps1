<# 
###################################################################################
	Get-Uptime / 1.0.0
	kemotep
	2019-04-20 / GNU Lesser General Public License v3
	kemotep@gmail.com / https://github.com/kemotep/ 
###################################################################################
Neat script from /r/sysadmin. Load this using Import-Module.
#>
   function Get-Uptime {
    <#  
    .Synopsis
       Get a computers uptime
    .DESCRIPTION
       This function will allow you to determine the uptime of a computer using a wmi query
    #>

    param (
        [Parameter(mandatory = $true, ValueFromPipeline = $true)]
        [string]$ComputerName = @(".")
        )
    process {

        # See if it responds to a ping, otherwise the WMI queries will fail
        $query = "select * from win32_pingstatus where address = '$ComputerName'"
        $ping = Get-WmiObject -query $query
        if ($ping.protocoladdress) {
            # Ping responded, so connect to the computer via WMI
            $os = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName -ev myError -ea SilentlyContinue
            $LastBootUpTime = $os.ConvertToDateTime($os.LastBootUpTime)
            $LocalDateTime = $os.ConvertToDateTime($os.LocalDateTime)

            # Calculate uptime - this is automatically a timespan
            $up = $LocalDateTime - $LastBootUpTime

            # Split into Days/Hours/Mins
            $uptime = "$($up.Days) days, $($up.Hours)h, $($up.Minutes)mins"

            # Save the results for this computer in an object
            $results = new-object psobject
            $results | add-member noteproperty LastBootUpTime $LastBootUpTime
            $results | add-member noteproperty ComputerName $os.csname
            $results | add-member noteproperty uptime $uptime

            # Display the results
            $results | Select-Object ComputerName, LastBootUpTime, uptime
            }
        else {
            # Error: PC did not respond
            "$ComputerName did not respond."
        }
        # End of the process block
    }
    # End of the Function
}