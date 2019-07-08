$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.1.4'
$url64              = "https://github.com/knqyf263/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$url                = "https://github.com/knqyf263/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-32bit.zip"
$checksum64         = "e26a2fcc11bd12b8fc4d2acf1ed0fd8241d992bd6c0c245fd99d468c1cb257fe"
$checksum           = "5c6c905d08b1df9ef662254db49a75d8c2dd082309b1485c564d48e3aa42addc"
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