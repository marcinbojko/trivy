$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.1.6'
$url64              = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$url                = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-32bit.zip"
$checksum64         = "2b22b9156aba977c8e9b5fb2917c526be6a25c7e28b541690cfc6a53585d3b45"
$checksum           = "0675c2fef7a19bfc8a9138de5bb3736c381b8319aef46411cb3bb27f7208cefa"
$bindir             = Join-Path $env:ChocolateyInstall "lib\trivy\tools\trivy.exe"

[regex]$refreshdbparams = “(?i)^(Yes|No)$”

$pp=Get-PackageParameters
if (!$pp['RefreshDB']) {$pp['RefreshDB']='No'}
else {
    if ($pp['RefreshDB'] -notmatch $refreshdbparams) {
      Write-Output "Wrong value $($pp.RefreshDB) for parameter RefreshDB"
      exit (1)
    }
}
$packageArgs = @{
  packageName     = $packageName
  fileType        = 'msi'
  url64bit        = $url64
  url             = $url
  UnzipLocation   = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksumType64  = 'sha256'
  checksumType    = 'sha256'
  checksum64      = $checksum64
  checksum        = $checksum
}

Install-ChocolateyZipPackage @packageArgs

# Write-Output $bindir
try {
    if ($($pp.RefreshDB) -eq "Yes") {
      Write-Output "Updating Trivy databases - it can take a while"
      & $bindir '--reset'
      & $bindir '--refresh' '--quiet'
    }
}
catch {
  # We don't care about updates, if they'll fail, do not fail package
  exit (0)
}