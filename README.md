# Trivy

## Description

A Simple and Comprehensive Vulnerability Scanner for Containers, Suitable for CI - [https://github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy)

## Features

* Install and uninstall via Chocolatey
* Supports 32 and 64-bit version

## Dependencies

Due to proper usage and DB update, package `git` is required, minimal dependency version is `2.40.1`

## Usage

### Package Parameters

* /DownloadDatabaseOnly = (Yes/No) - If set to "Yes", after instalation Trivy will update DB only

  If not set, then "No" is default answer

  Without `git` package instalation can take a while

### Direct

```cmd
choco install trivy -y
```

or with DB update during instalation

```cmd
choco install trivy -y --params "/DownloadDatabaseOnly=Yes"
```

### YAML (Foreman, puppetlabs/chocolatey module)

```yaml
trivy:
  ensure: latest
  provider: chocolatey
```

or

```yaml
trivy:
  ensure: latest
```
