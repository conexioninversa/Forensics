#██╗  ██╗███████╗██████╗ ███╗   ██╗███████╗██╗      ██████╗ ██╗   ██╗███╗   ███╗██████╗ 
#██║ ██╔╝██╔════╝██╔══██╗████╗  ██║██╔════╝██║      ██╔══██╗██║   ██║████╗ ████║██╔══██╗
#█████╔╝ █████╗  ██████╔╝██╔██╗ ██║█████╗  ██║█████╗██║  ██║██║   ██║██╔████╔██║██████╔╝
#██╔═██╗ ██╔══╝  ██╔══██╗██║╚██╗██║██╔══╝  ██║╚════╝██║  ██║██║   ██║██║╚██╔╝██║██╔═══╝  
#██║  ██╗███████╗██║  ██║██║ ╚████║███████╗███████╗ ██████╔╝╚██████╔╝██║ ╚═╝ ██║██║      
#╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     
                                                                                       

# This script allows you to dump the Kernel part of the ram without using any external tool

param (
    [string]$outputPath = "$env:temp\"
)

$me = Get-CimInstance -ClassName MSFT_StorageSubSystem -Namespace Root\Microsoft\Windows\Storage;
Invoke-CimMethod -InputObject $me -MethodName "GetDiagnosticInfo" -Arguments @{DestinationPath=$outputPath; IncludeLiveDump=$true};


# Replace "$env:temp\" with a route from your computer disk or add a route as a parameter to the script
# Special thanks to Grzegorz Tworek - 0gtweet.
