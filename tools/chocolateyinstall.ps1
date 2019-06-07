$ErrorActionPreference = 'Stop';

$packageName        = 'trivy'
$version            = '0.1.2'
$url64              = "https://github.com/knqyf263/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-64bit.zip"
$url                = "https://github.com/knqyf263/trivy/releases/download/v"+$version+"/trivy_"+$version+"_Windows-32bit.zip"
$checksum64         = "87ce3770bbd20027703a07c0d8916a387685f94a8b70cfcf475804180c0420d3"
$checksum           = "002bca245d19803ceaf18f734ddd5303f7fb468cdfdf54bed060be44c0cff3d7"
$bindir             = Join-Path $env:ChocolateyInstall "lib\trivy\tools\trivy.exe"

[regex]$refreshdbparams = “(?i)^(Yes|No)$”

$pp=Get-PackageParameters
if (!$pp['RefreshDB']) {$pp['RefreshDB']='No'}
else {
    if ($pp['RefreshDB'] -notmatch $refreshdbparams)
        { Write-Output "Wrong value $($pp.RefreshDB) for parameter RefreshDB"
         exit (1) }
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