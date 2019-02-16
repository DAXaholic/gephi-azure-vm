# Install Chocolatey
Invoke-Expression
    (Invoke-WebRequest 'https://chocolatey.org/install.ps1').Content

# Install Java
choco.exe install javaruntime -y

# Download Gephi Installer
$invokeWebReqArgs = @{
    Uri = 'https://github.com/gephi/gephi/releases/download/v0.9.2/gephi-0.9.2-windows.exe'
    OutFile = 'gephi.exe'
}
Invoke-WebRequest @invokeWebReqArgs

# Install Gephi
.\gephi.exe /SILENT
