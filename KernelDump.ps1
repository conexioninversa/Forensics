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

$ss = Get-CimInstance -ClassName MSFT_StorageSubSystem -Namespace Root\Microsoft\Windows\Storage;
Invoke-CimMethod -InputObject $ss -MethodName "GetDiagnosticInfo" -Arguments @{DestinationPath=$outputPath; IncludeLiveDump=$true};


# Replace "$env:temp\" with a route from your computer disk or add a route as a parameter to the script
# Special thanks to Grzegorz Tworek - 0gtweet.
