# Where the Microsoft Storage namespace is available (known not to be available in Win7), PowerShell can be used to invoke a native live memory dump
# This example has been modified to work with KAPE by Eric Zimmmerman
$ss = Get-CimInstance -ClassName MSFT_StorageSubSystem -Namespace Root\Microsoft\Windows\Storage;
Invoke-CimMethod -InputObject $ss -MethodName "GetDiagnosticInfo" -Arguments @{DestinationPath=%destinationDirectory%; IncludeLiveDump=$true};
# Replace %destinationDirectory% with a route from your team
# Special thanks to Grzegorz Tworek - 0gtweet.
