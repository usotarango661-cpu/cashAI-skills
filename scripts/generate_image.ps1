#!/usr/bin/env pwsh
# generate_image.ps1 - Generate an image using Google Gemini Nano Banana models
# Usage: .\generate_image.ps1 -ApiKey "KEY" -Prompt "..." -OutFile "output.png"

param(
    [Parameter(Mandatory=$true)]
    [string]$ApiKey,

    [Parameter(Mandatory=$true)]
    [string]$Prompt,

    [Parameter(Mandatory=$true)]
    [string]$OutFile,

    [string]$Model = "models/gemini-2.5-flash-image"
)

$ErrorActionPreference = "Stop"

# Ensure output directory exists
$outDir = Split-Path -Parent $OutFile
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

$body = @{
    contents = @(
        @{
            parts = @(
                @{ text = $Prompt }
            )
        }
    )
    generationConfig = @{
        responseModalities = @("TEXT", "IMAGE")
    }
} | ConvertTo-Json -Depth 10

$uri = "https://generativelanguage.googleapis.com/v1beta/$($Model):generateContent?key=$ApiKey"

try {
    $resp = Invoke-RestMethod -Uri $uri -Method Post -ContentType "application/json" -Body $body
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
    $errorBody = $reader.ReadToEnd()
    Write-Error "HTTP $statusCode`: $errorBody"
    exit 1
}

$imgPart = $resp.candidates[0].content.parts | Where-Object { $_.inlineData }

if (-not $imgPart) {
    $textPart = $resp.candidates[0].content.parts | Where-Object { $_.text }
    Write-Error "No image returned. Text response: $($textPart.text)"
    exit 1
}

$bytes = [Convert]::FromBase64String($imgPart.inlineData.data)
[System.IO.File]::WriteAllBytes($OutFile, $bytes)

Write-Host "Image saved: $OutFile ($([math]::Round($bytes.Length / 1KB, 1)) KB)"
