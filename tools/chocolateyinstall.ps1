﻿$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.58.1'
$url64              = "https://github.com/aquasecurity/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$checksum64         = '2a5cdabc704ec4b8e9f26a2ccb2d8aea3f0d2f28dc683737f1c8aab1c160fe9a'
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