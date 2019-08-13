#Written by Eder Juarez
#Date 12/28/2018
#I wrote this to compile a report of all my PDF documents in my userprofile.
#Modified 5/18/2019 - I modified $reportname as this is a scheduled task now.

#Sets the execution policy
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force

#This variable is where the report saves.
$SaveLocation = "$env:OneDrive\Documents"

#Part of the name for the reportname
$DayName = Get-Date -UFormat "%B %d"

#Sets the variable for the report name by the user. 
$ReportName = "PDF Report for $DayName "

#This works very similar to 'IF EXIST' from the command line days to test if the file exists already.
If (Test-Path $SaveLocation\$ReportName.CSV) {
#Exits Script.
Exit
}

#Sets the variable to search for PDF documents in my userprofile. 
$PDF = Get-ChildItem -Path $env:USERPROFILE '*.PDF' -Recurse | Select-Object -Property *

#Adds an Alias property to use 'FilePath' instead of 'FullName' in the report csv column.
$PDF | Add-Member -MemberType AliasProperty -Name FilePath -Value FullName

#Adds a propertyset. I did this just to save time typing and to practice. These are the properties important to me.
$PDF | Add-Member -MemberType PropertySet -Name MyFavs -Value DirectoryName,Name,CreationTime,LastAccessTime

#Last but not least, this goes ahead and saves to the desktop.
$PDF | Select-Object MyFavs,FilePath | Export-CSV -Path $SaveLocation\$ReportName.csv -Force
