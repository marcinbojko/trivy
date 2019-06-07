# Trivy

## Description

A Simple and Comprehensive Vulnerability Scanner for Containers, Suitable for CI - [https://github.com/knqyf263/trivy](https://github.com/knqyf263/trivy)

## Features

* Install and uninstall via Chocolatey
* Supports 32 and 64-bit version

## Dependencies

Due to proper usage and DB update, package `git` is required.

## Changelog

### 2019-05-27 Build 0.1.1

* version 0.1.1
* 64-bit version - [https://www.virustotal.com/#/file/1478078ae8957d697f576572f0f8f7e7abb6fe27fc62afdc16adcd1f511ab150/detection](https://www.virustotal.com/#/file/1478078ae8957d697f576572f0f8f7e7abb6fe27fc62afdc16adcd1f511ab150/detection)
* 32-bit version - [https://www.virustotal.com/#/file/2585154eac2bdf6f273b580cfc7647a854ec6a8d98e2fb8696bace8d5d383545/detection](https://www.virustotal.com/#/file/2585154eac2bdf6f273b580cfc7647a854ec6a8d98e2fb8696bace8d5d383545/detection)

## Usage

### Package Parameters

* /RefreshDB = (Yes/No) - If set to "Yes", after instalation Trivy will reset and update databases.

  If not set "No" is default answer

  Without `git` package instalation can take a while

### Direct

```cmd
choco install trivy -y
```

or with DB update during instalation

```cmd
choco install trivy -y --params "/RefreshDB=Yes"
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
