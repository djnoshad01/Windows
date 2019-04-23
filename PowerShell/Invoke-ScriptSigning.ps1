<#
###########################################################################
	Kemotep's PowerShell Code Signing Script
	author: kemotep
	version: 0.01
	2019-04-20 / GNU Lesser General Public License v3
	kemotep@gmail.com / https://github.com/kemotep/
	This script requires Admin to Run!
###########################################################################
Disable Set-ExecutionPolicy, then run this script. 
Sign your scripts then renable Set-ExecutionPolicy to prevent unsigned Powershell Scripts.
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