# Forensics

Forensic scripts for collecting artifacts

* `Smell.ps1` - Acquisition of volatile artifacts with PowerShell
* `PowerShell_Signed.ps1` - Checks the digital signature of the DLL and EXE files in the folders c:\windows\system32 and C:\Windows\SysWOW64\. The result is saved
in the folder c:\temp with the filename 'Status.json'

`PARAMETER Status` An optional parameter; defines which states to report on. It can be Unsigned (default), Unknown Error, Valid or All.

`PARAMETER OutputFile` An optional parameter; defines where to write the results. The default value is "C:\temp"

Unsigned files in these folders could be an indication of lateral movement, which is used by attackers
for lateral movement between machines. The results are saved by default in "C:\temp"

* `WIFIPassView.ps1` - This script allows you to obtain the list of WIFI connected to the equipment and their stored passwords.
The result is written to the WIFIPassView.csv file
