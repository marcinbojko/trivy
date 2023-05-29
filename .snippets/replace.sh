#!/usr/bin/env bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac


file="../trivy.nuspec"
powershell="../tools/chocolateyinstall.ps1"

case "${machine}" in
    Linux*)     version=$(grep -oPm1 "(?<=<version>)[^<]+" "$file");
                id=$(grep -oPm1 "(?<=<id>)[^<]+" "$file");
                url64=https://github.com/aquasecurity/"$id"/releases/download/v"$version"/"$id"_"$version"_windows_64bit.zip;
                checksum64_file=https://github.com/aquasecurity/"$id"/releases/download/v"$version"/"$id"_"$version"_checksums.txt;
                checksum64=$(curl -sL "$checksum64_file" | grep windows-64bit.zip | awk '{print $1}');
                sed_binary=sed;;
    Mac*)       version=$(ggrep -oPm1 "(?<=<version>)[^<]+" "$file");id=$(ggrep -oPm1 "(?<=<id>)[^<]+" "$file");
                url64=https://github.com/aquasecurity/"$id"/releases/download/v"$version"/"$id"_"$version"_windows_64bit.zip;
                checksum64_file=https://github.com/aquasecurity/"$id"/releases/download/v"$version"/"$id"_"$version"_checksums.txt;
                checksum64=$(curl -sL "$checksum64_file" | grep windows-64bit.zip | awk '{print $1}');
                sed_binary=gsed;;
    *)          echo "UNKNOWN:${machine}"
esac

if [ -n "$version" ] && [ -n "$checksum64" ]; then
    echo "version and checksum are not empty"
    echo "$version"
    echo "$id"
    echo "$url64"
    echo "$checksum64"

    "$sed_binary" -i "s|^\$version.*|\$version            = '$version'|g" "$powershell"
    "$sed_binary" -i "s|^\$checksum64.*|\$checksum64         = '$checksum64'|g" "$powershell"
else
    echo "version or checksum is/are empty"
    echo "version: $version"
    echo "checksum: $checksum64"
fi
