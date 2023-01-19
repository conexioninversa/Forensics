# Forensics

Forensic scripts for collecting artifacts

* `Smell.ps1` - Acquisition of volatile artifacts with PowerShell
* `PowerShell_Signed.ps1` - Checks the digital signature of the DLL and EXE files in the folders c:\windows\system32 and C:\Windows\SysWOW64\. The result is saved
in the folder c:\temp with the filename 'Status.json'
* `WIFIPassView.ps1` - This script allows you to obtain the list of WIFI connected to the equipment and their stored passwords.
The result is written to the WIFIPassView.csv file
* `KernelDump.ps1` - This script allows you to dump the Kernel part of the ram without using any external tool. Where the Microsoft Storage namespace is available (known not to be available in Win7), PowerShell can be used to invoke a native live memory dump. This example has been modified to work with KAPE by Eric Zimmmerman
