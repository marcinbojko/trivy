$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.1.3'
$url64              = "https://github.com/knqyf263/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$url                = "https://github.com/knqyf263/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-32bit.zip"
$checksum64         = "8cae9608f023f4d6f13528f2ff8c838ec5a2442a861d24f8d2c8257ea19cb58f"
$checksum           = "29edcf6a5f5271d3ef548be9850f093e39316f50e1d78988e8bb9ec2eca88a00"
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