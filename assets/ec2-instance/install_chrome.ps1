<powershell>
Set-Location -Path ([System.Environment]::GetFolderPath("Desktop"))
echo [InternetShortcut] > torque.url
echo URL="https://portal.qtorque.io/login" >> torque.url
</powershell>