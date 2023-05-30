# Trivy

## Description

A Simple and Comprehensive Vulnerability Scanner for Containers, Suitable for CI - [https://github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy)

## Features

* Install and uninstall via Chocolatey
* Supports only 64bit version

## Usage

### Package Parameters

* /DownloadDatabaseOnly = (Yes/No) - If set to "Yes", after instalation Trivy will update DB only

  If not set, then "No" is default answer

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
