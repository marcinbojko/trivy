# Trivy

## Description

A Simple and Comprehensive Vulnerability Scanner for Containers, Suitable for CI - [https://github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy)

## Features

* Install and uninstall via Chocolatey
* Supports 32 and 64-bit version

## Dependencies

Due to proper usage and DB update, package `git` is required, minimal dependency version is `2.17.0`

## Changelog

### 2019-11-14 Build 0.1.7

* version 0.1.7

### 2019-08-25 Build 0.1.6

* version 0.1.6

### 2019-08-22 Build 0.1.5

* version 0.1.5

### 2019-07-08 Build 0.1.4

* version 0.1.4

### 2019-06-27 Build 0.1.3

* version 0.1.3

### 2019-06-07 Build 0.1.2

* version 0.1.2

### 2019-05-27 Build 0.1.1

* version 0.1.1
* 64-bit version - [https://www.virustotal.com/#/file/1478078ae8957d697f576572f0f8f7e7abb6fe27fc62afdc16adcd1f511ab150/detection](https://www.virustotal.com/#/file/1478078ae8957d697f576572f0f8f7e7abb6fe27fc62afdc16adcd1f511ab150/detection)
* 32-bit version - [https://www.virustotal.com/#/file/2585154eac2bdf6f273b580cfc7647a854ec6a8d98e2fb8696bace8d5d383545/detection](https://www.virustotal.com/#/file/2585154eac2bdf6f273b580cfc7647a854ec6a8d98e2fb8696bace8d5d383545/detection)

## Usage

### Package Parameters

* /RefreshDB = (Yes/No) - If set to "Yes", after instalation Trivy will reset and update databases.

  If not set, then "No" is default answer

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
