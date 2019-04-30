  ## Exchange Powershell Commands

Here is a list of useful powershell one-liners to help with exchange management. This is pretty much everything you need for exchange management.
Note: You need to have an elevated shell, allow remote signed powershell scripts, and permissions to make changes on exchange with your user.

# Table of Contents

  TODO

# Documentation
 
[Here](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps) is the Microsoft documentation on Connecting to Exchange Online via Powershell.

>     $UserCredential = Get-Credential
>     $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
>     Import-PSSession $Session -DisableNameChecking
	
# Mailbox Commands

 Create Mail User
 
    New-Mailox -name "USERNAME" -alias USERNAME -organizationalunit 'domain.example.com/PATH/TO/OU' -userprincipalname USERNAME -samaccountname USERNAME -password fourwordsuppercase -resetpasswordonnextlogon: $true -database 'EXCHANGE_DB'

 Rename Mailbox

    Get-Mailbox OLDMAILBOX | Set-Mailbox -displayname 'NEW MAILBOX' -name 'NEW MAILBOX' -alias NEWMAILBOX

 Create a Shared Mailbox

    New-Mailbox -shared -name "MAILBOX NAME" -alias "MAILBOXALIAS" -organizationalunit 'domain.example.com/PATH/TO/OU' -userprincipalname MAILBOXALIAS@domain.example.com -samaccountname MAILBOXALIAS -database 'EXCHANGE_DB'

 Create Room for meetings, etc.

    New-Mailbox -room -name "ROOM NAME" -alias "ROOMALIAS" -organizationalunit 'domain.example.com/PATH/TO/OU' -userprincipalname ROOMALIAS@domain.example.com -samaccountname ROOMALIAS -database 'EXCHANGE_DB'
	
 Create Equipment (Same as before but with the `-equipment` option instead of shared or room`)

 Full Access Rights
 
    Get-Mailbox MAILBOX | Add-MailboxPermission -user USERNAME -AccessRights FullAccess
	
 Send on Behalf Rights
 
    Get-Mailbox MAILBOX | Set-Mailbox -grantsendonbehalf USERNAME
	
 Send As Rights
 
    Get-Mailbox MAILBOX | Add-ADPermission -user USERNAME -ExtendRights Send-As

 Both Full Access and Send As Rights in one go
 
    Get-Mailbox MAILBOX | Add-MailboxPermission -user USERNAME -AccessRights FullAccess | Add-ADPermission -user USERNAME -ExtendRights Send-As

 Change Mailbox Type [equipment|room|shared|user]
 
    Get-Mailbox MAILBOXALIAS | Set-Mailbox -Type: [TYPE]
	
 Add Contact
 
    New-MailContact -Name 'LastName, FirstName' -alias FirstName.LastName -ExternalEmailAddress 'EmailAddress@example.com' -organizationalunit domain.example.com/PATH/TO/ContactsOU
	
# Automatic Processing Commands
 
 Calendar Invitation AutoAccept
 
    Get-Mailbox | Set-CalendarProcessing -automateprocessing AutoAccept -AddOrganizerToSubject $false -BookingWindowInDays 547 -MaximumDurationInMinutes 9360 -DeleteSubject $false -DeleteComments $false -EnforceSchedulingHorizon $false -RemovePrivateProperty $false
 
 Calendar AutoUpdate
 
    Get-Mailbox | Set-CalendarProcessing -automateprocessing AutoUpdate -AddOrganizerToSubject $false -BookingWindowInDays 547 -MaximumDurationInMinutes 9360 -DeleteSubject $false -DeleteComments $false -EnforceSchedulingHorizon $false -RemovePrivateProperty $false

# Permissions Commands

 Mailbox Folder Permissions
  (Individual Permissions:[CreateItems|CreateSubfolders|DeleteAllItems|DeleteOwnedItems|EditAllItems|EditOwnedItems|FolderContact|FolderOwner|FolderVisible|ReadItems])
  (Roles:[Author|Contributor|Editor|None|NonEditingAuthor|Owner|PublishingEditor|PublishingAuthor|Reviewer]
 
    Add-MailboxFolderPermission MAILBOX:\FOLDER -user UserOrSecurityGroup -accessrights [PERMISSION or ROLE]

 Calendar Folder Permissions
  (Roles specific to Calendar folders:[AvailabilityOnly|LimitedDetails]

    Add-MailboxFolderPermission MAILBOX:\Calendar -user UserOrSecurityGroup -accessrights [PERMISSION or ROLE]

# Distribution List Commands

 Create Non-Security Distribution Group
 
    New-DistributionGroup -name 'DL GROUP NAME' -type 'distribution' -organizationalunit 'domain.example.com/PATH/TO/OU' -alias 'DLGROUPNAME' -samaccountname 'DLGROUPNAME' -managedby user1,user2,user3,userN | set-distributiongroup -CustomAttribute2 AttributeName -requiresenderauthenticationenabled: $true

 Create Security Distribution Group 
  
    New-DistributionGroup -name 'DL SECURITY GROUP NAME' -type 'security' -organizationalunit 'domain.example.com/PATH/TO/OU' -alias 'DLSECURITYGROUPNAME' -samaccountname 'DLSECURITYGROUPNAME' -managedby user1,user2,user3,userN | set-distributiongroup -CustomAttribute2 AttributeName -requiresenderauthenticationenabled: $false

 Add Members to Distribution List
 
    Add-DistributionGroupMember 'DL GROUP NAME' -member USerAlias

 Remove Members from Distribution List
 
    Remove-DistributionGroupMember -Identity 'DL GROUP NAME' -Member UserAlias -BypassSecurityGroupManagerCheck

 Get Distribution List Member
 
    Get-DistributionGroupMember "UserAlias" | fl PrimarySmtpAddress
	
 List Distribution List Membership of User by Distinguished Name
  (Step 1)
    Get-Mailbox 'UserAlias' | select DistinguishedName | Export-CSV $env:UserProfile\DLMember.csv -notype -append
  (Step 2)
    Get-DistributionGroup -ResultSize Unlimited -Filter 'Members -eq "User Distinguished Name"' | select name>$env:UserProfile\USERNAME.txt

 Add Manager to Distribution List without Manager Replacement
 
    Get-DistributionGroup 'DL GROUP NAME' | Set-DistributionGroup -managedby @{Add='UserAlias'} -BypassSecurityGroupManagerCheck

 Add Manager to Distribution List with Manager Replacement
 
    Get-DistributionGroup 'DL GROUP NAME' | Set-DistributionGroup -managedby UserAlias -BypassSecurityGroupManagerCheck
	
 Rename Distribution List
 
    Get-DistributionGroup 'CURRENT DL GROUP NAME' | Set-DistributionGroup -DisplayName 'NEW DL GROUP NAME' -alias NEWDLGROUPNAME -BypassSecurityGroupManagerCheck
	
# Tracking Commands
 
 TODO