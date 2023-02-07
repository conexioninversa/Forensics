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
