# Trivy

![Chocolatey](https://img.shields.io/badge/Chocolatey-orange)
![Windows2016](https://img.shields.io/badge/Windows-2019-blue)
![Windows2019](https://img.shields.io/badge/Windows-2019-blue)
![Windows2022](https://img.shields.io/badge/Windows-2019-blue)
![Windows10](https://img.shields.io/badge/Windows-10-lightblue)
![Windows11](https://img.shields.io/badge/Windows-11-lightblue)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/marcinbojko)

Consider buying me a coffee if you like my work. All donations are appreciated. All donations will be used to pay for pipeline running costs

<!-- TOC -->

- [Trivy](#trivy)
  - [Description](#description)
  - [Features](#features)
  - [Usage](#usage)
    - [Package Parameters](#package-parameters)
    - [Direct](#direct)
    - [YAML Foreman, puppetlabs/chocolatey module](#yaml-foreman-puppetlabschocolatey-module)

<!-- /TOC -->


## Description

A Simple and Comprehensive Vulnerability Scanner for Containers, Suitable for CI - [https://github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy)

## Features

- Install and uninstall via Chocolatey
- Supports only 64bit version

## Usage

### Package Parameters

 /DownloadDatabaseOnly = (Yes/No) - If set to "Yes", after instalation Trivy will update DB only

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
