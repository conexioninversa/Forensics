<#
.SINOPSIS

Comprueba los directorios system32 y SysWOW64 por el estado de su firma digital.

.PARÁMETRO Estado

Un parámetro opcional; define sobre qué estados informar. Puede ser No Firmado (por defecto), Error Desconocido, Válido o Todo.

PARÁMETRO SalidaFichero

Un parámetro opcional; define dónde escribir los resultados. El valor por defecto es "C:\temp"

EJEMPLO
Firma.ps1 -Estado SinFirma -SalidaFichero "C:\temp\Nombrefichero.extension"

Firma.ps1 se utiliza para comprobar la firma digital de los ficheros DLL y EXE en
los directorios 'C:\Windows\system32\' y 'C:\Windows\SysWOW64\'. 
Los ficheros sin firmar en estas carpetas podría ser una indicación de movimiento lateral, que es utilizada por los atacantes
para el movimiento lateral entre máquinas. Los resultados se guardan por defecto en "C:\temp"

Autor: ConexionInversa

#>

Param(
    [string]$Estado = "NotSigned",
    [string]$OutputFilePath = "C:\temp\"
)

clear
Write-Progress -Activity "Comprobando ficheros..."

$sys32 = Get-ChildItem "C:\Windows\system32\*.exe"
$sys64 = Get-ChildItem "C:\Windows\SysWOW64\*.exe"
$sys32dll = Get-ChildItem "C:\Windows\system32\*.dll"
$sys64dll = Get-ChildItem "C:\Windows\SysWOW64\*.dll"

$SystemDirectories = @($sys32, $sys64, $sys32dll, $sys64dll)

function EstadoDelEjecutable($EjecutableRevisar, $ResultadoDeFirma)
{
    $md5 = Get-FileHash -Algorithm MD5 $EjecutableRevisar.FullName
    $sha256 = Get-FileHash -Algorithm SHA256 $EjecutableRevisar.FullName
    $ResultadoHash = $ResultadoDeFirma | Select-Object *, @{n="FileHashMd5"; e={$md5.Hash}}, @{n="FileHashSha256"; e={$sha256.Hash}}
    $ResultadoJSON = $ResultadoHash | ConvertTo-Json -Depth 4
    $ResultadoJSON | Out-File -Append $OutputFilePath"\EstadoDeFirma.json"
}

function ComprobacionFirma($Directorio)
{
    ForEach($EjecutableRevisar in $Directorio)
    {
        if ((Get-Item $EjecutableRevisar.Fullname) -is [System.IO.DirectoryInfo]){
            continue
        }else{
            $ResultadoDeFirma = Get-AuthenticodeSignature $EjecutableRevisar.FullName -ErrorAction SilentlyContinue | Select *
            if ("All" -in $Estado){
                EstadoDelEjecutable $EjecutableRevisar $ResultadoDeFirma
            } elseif ($Estado -in $ResultadoDeFirma.Status) {
                EstadoDelEjecutable $EjecutableRevisar $ResultadoDeFirma
            }
        }
    }    
}

function main()
{
    ForEach($Directorio in $SystemDirectories){
        ComprobacionFirma($Directorio)
    }
}

main

write-host "----------------------------------------------------"
write-host "                    RESULTADOS                      "
write-host "----------------------------------------------------"
write-host " "
Get-Content -Path c:\temp\EsdadoDeFirma.json
