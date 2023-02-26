#Habilitando Scripts
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -force
#Set-ExecutionPolicy Unrestricted -force

#URL de download
$url = "http://192.168.0.116:8000/certificate.pfx"
#Destino
$output = "C:\temp"

#Transfere o certificado
Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output

sleep 2

#Instala o certificado

#Import-PfxCertificate -FilePath C:\temp\certificate.pfx -Password (ConvertTo-SecureString -String '123456' -AsPlainText -Force) -CertStoreLocation Cert:\LocalMachine\Root
#Import-PfxCertificate -FilePath C:\temp\certificate.pfx -Password (ConvertTo-SecureString -String '123456' -AsPlainText -Force) -CertStoreLocation Cert:\LocalMachine\CA

Import-PfxCertificate -FilePath C:\temp\certificate.pfx -Password (ConvertTo-SecureString -String '123456' -AsPlainText -Force) -CertStoreLocation Cert:\CurrentUser\Root
Import-PfxCertificate -FilePath C:\temp\certificate.pfx -Password (ConvertTo-SecureString -String '123456' -AsPlainText -Force) -CertStoreLocation Cert:\CurrentUser\CA

#Configura chaves de registro do Windows ativando o proxy
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings' -Name 'ProxyEnable' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings' -Name 'ProxyServer' -value '192.168.0.116:8080'