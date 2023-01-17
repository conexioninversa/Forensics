Write-Host -ForegroundColor Cyan "[+]  WIFI Discovery"
	
	$Perfil = "C:\Users\" + $Username 
	Write-Host -ForegroundColor Green "[+]  WIFI Password Found"
	foreach($perfil in (netsh wlan show profiles) | Select-String "\:(.+)$")
{
    $nombrep = $perfil.Matches.Groups[1].Value.Trim()
    (netsh wlan show profile name="$nombrep" key=clear) | Select-String -Pattern "SSID Name | Contents" 
}

# Change Pattern "SSID Name | Contents" to the language of your operating system.
# For example to search in Spanish : Select-String -Pattern "Nombre de SSID | Contenido"
