<##########################################################################
	Kemotep's PowerShell Code Signing Script / 1.1
	
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
###########################################################################
This script requires Admin to Run!
Disable Set-ExecutionPolicy, then run this script. 
Sign your scripts then renable Set-ExecutionPolicy to prevent unsigned Powershell Scripts.
TODO: Better handle or split out last block for script signing
#>
function Invoke-ScriptSigning {
# Here we start by creating some variables
$CertName = "Kemotep's Script Signing Certificate"
$CertPath = "$env:UserProfile\ScriptSigningCertificate.pfx"
$CertPW = ConvertTo-SecureString -String "Placeholder Password. Remember to replace this!" -Force -AsPlainText

# Create the certificate. 
New-SelfSignedCertificate -subject $CertName -Type CodeSigningCert | Export-PfxCertificate -FilePath $CertPath -password $CertPW
certutil $CertPath

# Add new certificate to relevant CertStores
Import-PfxCertificate -FilePath $CertPath -CertStoreLocation "cert:\LocalMachine\My" -Password $CertPW
Import-PfxCertificate -FilePath $CertPath -CertStoreLocation "cert:\LocalMachine\Root" -Password $CertPW
Import-PfxCertificate -FilePath $CertPath -CertStoreLocation "cert:\LocalMachine\TrustedPublisher" -Password $CertPW

# Uncomment to sign all Powershell Scripts
# $NewCert = Get-PfxCertificate -FilePath $CertPath
# $ScriptDir = Path\to\PowerShell\Scripts #Change as needed
# cd $ScriptDir
# get-childitem *ps1 | Set-AuthenticodeSignature -Certificate $NewCert
}
