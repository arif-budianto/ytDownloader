$ErrorActionPreference = "Stop"

$NodeVersion = "v22.22.1"
$NodeUrl = "https://nodejs.org/dist/$NodeVersion/win-x64/node.exe"
$FfmpegUrl = "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"

$TempDir = Join-Path $PWD ".tmp-downloads"
if (Test-Path $TempDir) {
    Remove-Item -Recurse -Force $TempDir
}
New-Item -ItemType Directory -Path $TempDir | Out-Null

try {
    Invoke-WebRequest -Uri $NodeUrl -OutFile "node.exe"

    $ffmpegZip = Join-Path $TempDir "ffmpeg.zip"
    Invoke-WebRequest -Uri $FfmpegUrl -OutFile $ffmpegZip
    Expand-Archive -Path $ffmpegZip -DestinationPath $TempDir -Force

    $ExtractedDir = Get-ChildItem -Path $TempDir -Directory | Where-Object { $_.Name -like 'ffmpeg-*' } | Select-Object -First 1
    if (-not $ExtractedDir) {
        throw "Extracted ffmpeg directory not found"
    }

    if (Test-Path ".\\ffmpeg") {
        Remove-Item -Recurse -Force ".\\ffmpeg"
    }

    Move-Item -Path $ExtractedDir.FullName -Destination ".\\ffmpeg"
}
finally {
    if (Test-Path $TempDir) {
        Remove-Item -Recurse -Force $TempDir
    }
}
