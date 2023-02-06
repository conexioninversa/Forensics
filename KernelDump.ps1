#██╗  ██╗███████╗██████╗ ███╗   ██╗███████╗██╗      ██████╗ ██╗   ██╗███╗   ███╗██████╗ 
#██║ ██╔╝██╔════╝██╔══██╗████╗  ██║██╔════╝██║      ██╔══██╗██║   ██║████╗ ████║██╔══██╗
#█████╔╝ █████╗  ██████╔╝██╔██╗ ██║█████╗  ██║█████╗██║  ██║██║   ██║██╔████╔██║██████╔╝
#██╔═██╗ ██╔══╝  ██╔══██╗██║╚██╗██║██╔══╝  ██║╚════╝██║  ██║██║   ██║██║╚██╔╝██║██╔═══╝  
#██║  ██╗███████╗██║  ██║██║ ╚████║███████╗███████╗ ██████╔╝╚██████╔╝██║ ╚═╝ ██║██║      
#╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     
                                                                                       

# This script allows you to dump the Kernel part of the ram without using any external tool
# Where the Microsoft Storage namespace is available (known not to be available in Win7), PowerShell can be used to invoke a native live memory dump
# This example has been modified to work with KAPE by Eric Zimmmerman

param (
    [string]$outputPath = "$env:temp\"
)
# returning class instances:
Get-CimInstance -ClassName CIM_DataFile -Filter "Drive='c:' and Path='\\windows\\system32\\'" | Select-Object -Property Name, LastAccessed

# reading property value:
Get-CimInstance -ClassName CIM_DataFile -Filter "Drive='c:' and Path='\\windows\\system32\\'" | Select-Object -Property Name, LastAccessed | Foreach-Object {

  $Name = $_.Name
  $value = $_.LastAccessed
  "${Name}: LastAccessed = $value"
}

(Get-CimInstance -Class Win32_OperatingSystem).InstallDate
Get-CimInstance -ClassName Win32_OperatingSystem | select LastBootUpTime
gcim win32_process -filter "name='svchost.exe'" | select commandline, name

$ss = Get-CimInstance -ClassName MSFT_StorageSubSystem -Namespace Root\Microsoft\Windows\Storage;
Invoke-CimMethod -InputObject $ss -MethodName "GetDiagnosticInfo" -Arguments @{DestinationPath=$outputPath; IncludeLiveDump=$true};


# Replace "$env:temp\" with a route from your computer disk or add a route as a parameter to the script
# Special thanks to Grzegorz Tworek - 0gtweet.
