﻿$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.51.0'
$url64              = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$checksum64         = 'f762a3560c201fc41c40a347db3b3a261ed5ba101da3a3dec035b018dc41af46'
$bindir             = Join-Path $env:ChocolateyInstall "lib\trivy\tools\trivy.exe"

[regex]$downloaddatabaseonly = “(?i)^(Yes|No)$”

$pp=Get-PackageParameters
if (!$pp['DownloadDatabaseOnly']) {$pp['DownloadDatabaseOnly']='No'}
else {
    if ($pp['DownloadDatabaseOnly'] -notmatch $downloaddatabaseonly) {
      Write-Output "Wrong value $($pp.DownloadDatabaseOnly) for parameter DownloadDatabaseOnly"
      exit (1)
    }
}
$packageArgs = @{
  packageName     = $packageName
  fileType        = 'msi'
  url64bit        = $url64
  UnzipLocation   = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksumType64  = 'sha256'
  checksum64      = $checksum64
}

Install-ChocolateyZipPackage @packageArgs

# Write-Output $bindir
try {
    if ($($pp.DownloadDatabaseOnly) -eq "Yes") {
      Write-Output "Updating Trivy databases - it can take a while"
      & $bindir 'image --download-db-only'
    }
    else {
      Write-Output "No db update selected"
    }
}
catch {
  # We don't care about updates, if they'll fail, do not fail package
  exit (0)
}