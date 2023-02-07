###########################
# Find last access to files
###########################

# returning class instances:
Get-CimInstance -ClassName CIM_DataFile -Filter "Drive='c:' and Path='\\windows\\system32\\'" | Select-Object -Property Name, LastAccessed

# reading property value:
Get-CimInstance -ClassName CIM_DataFile -Filter "Drive='c:' and Path='\\windows\\system32\\'" | Select-Object -Property Name, LastAccessed | Foreach-Object {

  $Name = $_.Name
  $value = $_.LastAccessed
  "${Name}: LastAccessed = $value"
}


#########################
# Windows installation date
#########################

(Get-CimInstance -Class Win32_OperatingSystem).InstallDate

#########################
# Date of last start or boot of the operating system 
#########################

Get-CimInstance -ClassName Win32_OperatingSystem | select LastBootUpTime

#########################
# SVCHOST service command line
#########################

gcim win32_process -filter "name='svchost.exe'" | select commandline, name

#########################
# Identifying Brute Force Attacks
#########################

# Logs on the domain controller may be monitored for multiple failure instances to identify a brute force attack. 
# A domain controller logs a failed Kerberos ticket with log event 4771. 
# An example of a way to investigate a potential brute force attack is to run the command below on a domain controller to look for all failed logins
# within the last hour.

Get-WinEvent -Filterhashtable @{LogName='Seguridad';id=4771;starttime=(Get-Date).AddHours(-1);endtime=(Get-Date) }
