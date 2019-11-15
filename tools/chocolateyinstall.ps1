$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.1.7'
$url64              = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$url                = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-32bit.zip"
$checksum64         = "4000cda9964a4615aca1ecb29645049a2ba5dde44a61a76ad763ee5396e4ab32"
$checksum           = "3e1e3394208c6067e8e0d387373624507cb9c4f4eec74db1a67035f2aeb1c68c"
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