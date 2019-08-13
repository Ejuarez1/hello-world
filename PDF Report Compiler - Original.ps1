#Written by Eder Juarez
#Date 12/28/2018
#I wrote this to compile a report of all my PDF documents in my userprofile.

#Sets the execution policy
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force

#This variable is where the report saves.
$SaveLocation = "$env:OneDrive\Documents"

#Sets the variable for the report name by the user. 
$ReportName = Read-Host "Type in what you want the CSV file to be named, Then Press Enter"

#This works very similar to 'IF EXIST' from the command line days to test if the file exists already.
If (Test-Path $SaveLocation\$ReportName.CSV) {

#Outputs to console for user to read.
Write-Host "The CSV File '$ReportName' already exists on '$SaveLocation'" -ForegroundColor Cyan

#Outputs to console for user to read.
Write-Host "Choose a different name to name the file. Press Enter to Exit Script." -ForegroundColor Cyan

#Provides a 'pause'
Read-Host""

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
$PDF | Select-Object MyFavs,FilePath | Sort-Object -Property CreationTime -Descending | Export-CSV -Path $SaveLocation\$ReportName.csv -NoTypeInformation

#Let's user know where to find the file. Til next time my friend !!!
Write-Host "Your report has been saved to $SaveLocation. The File location is $SaveLocation\$ReportName.csv" -ForegroundColor Magenta

#Provides a 'pause'
Read-Host "Press Enter to exit the script."

#Exits Script.
Exit