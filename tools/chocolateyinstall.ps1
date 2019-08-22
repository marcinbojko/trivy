$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.1.5'
$url64              = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$url                = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-32bit.zip"
$checksum64         = "2d762065d17795f589be8825dcd53d4b9e7112203ecaa73f5343957750520351"
$checksum           = "dc71f31a8e309135c32282d41d82ce3b6230ae3486b89a9ffdfc146e9b11f155"
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