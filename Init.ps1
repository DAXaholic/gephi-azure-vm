param(
    $VmAdminUserName,
    $VmAdminPassword
)

$adminPasswordSecStr = ConvertTo-SecureString -AsPlainText -Force $VmAdminPassword
$credentials = [System.Management.Automation.PSCredential]::new(
    $VmAdminUserName,
    $adminPasswordSecStr)

Enable-PSRemoting -Force
Invoke-Command -Credential $credentials -ComputerName $env:COMPUTERNAME -ScriptBlock {

    # Install Chocolatey
    Invoke-Expression (Invoke-WebRequest 'https://chocolatey.org/install.ps1').Content

    # Install Java
    choco.exe install javaruntime -y

    # Download Gephi Installer
    $tempPath = [IO.Path]::GetTempPath()
    $tempDir = Join-Path -Path $tempPath -ChildPath 'GephiDownload'
    $null = New-Item -Path $tempDir -ItemType Directory -Force
    $tempExe = Join-Path -Path $tempDir -ChildPath 'gephi.exe'
    $invokeWebReqArgs = @{
        Uri     = 'https://github.com/gephi/gephi/releases/download/v0.9.2/gephi-0.9.2-windows.exe'
        OutFile = $tempExe
    }
    Invoke-WebRequest @invokeWebReqArgs

    # Install Gephi
    & $tempExe '/SILENT' | Out-Null
}
