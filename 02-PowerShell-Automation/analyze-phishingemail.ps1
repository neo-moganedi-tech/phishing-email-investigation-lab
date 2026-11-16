<#
.SYNOPSIS
Automated Phishing Email Investigation Tool

.DESCRIPTION
Reads a simulated phishing email, extracts sender
information and URLs, detects suspicious keywords,
checks sender and Reply-To mismatches, and generates
an investigation report and IOC CSV.

.AUTHOR
Cybersecurity Home Lab
#>

param(
    [string]$InputFile = (
        Join-Path $PSScriptRoot "..\01-Phishing-Email\phishing-email.txt"
    )
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " AUTOMATED PHISHING EMAIL INVESTIGATION " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. Check input file
if (-not (Test-Path -LiteralPath $InputFile)) {
    Write-Host "ERROR: Email file not found." -ForegroundColor Red
    Write-Host "Expected: $InputFile"
    exit 1
}

# 2. Read email content
$email = Get-Content -LiteralPath $InputFile -Raw

# 3. Create output directory
$outputDir = Join-Path $PSScriptRoot "Output"

New-Item -ItemType Directory -Path $outputDir -Force |
    Out-Null

# 4. Extract email headers
$fromLine = [regex]::Match(
    $email, '(?im)^From:\s*(.+)$'
).Groups[1].Value.Trim()

$replyLine = [regex]::Match(
    $email, '(?im)^Reply-To:\s*(.+)$'
).Groups[1].Value.Trim()

$subject = [regex]::Match(
    $email, '(?im)^Subject:\s*(.+)$'
).Groups[1].Value.Trim()

# 5. Extract email addresses
function Get-EmailAddress {
    param([string]$Text)

    $match = [regex]::Match(
        $Text,
        '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    if ($match.Success) {
        return $match.Value
    }

    return "Not found"
}

$sender = Get-EmailAddress $fromLine
$replyTo = Get-EmailAddress $replyLine

# 6. Extract sender domains
$senderDomain = "Not available"
$replyDomain = "Not available"

if ($sender -ne "Not found") {
    $senderDomain = ($sender -split '@')[-1].ToLower()
}

if ($replyTo -ne "Not found") {
    $replyDomain = ($replyTo -split '@')[-1].ToLower()
}

# 7. Compare sender and Reply-To domains
$domainMismatch = $false

if (
    $senderDomain -ne "Not available" -and
    $replyDomain -ne "Not available"
) {
    $domainMismatch = ($senderDomain -ne $replyDomain)
}

# 8. Extract URLs
$urlMatches = [regex]::Matches(
    $email,
    'https?://[^\s<>" ]+',
    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
)

$urls = @(
    foreach ($match in $urlMatches) {
        $match.Value.TrimEnd('.,;!?)')
    }
) | Select-Object -Unique

# 9. Detect suspicious keywords
$keywords = @(
    "urgent",
    "suspended",
    "verify",
    "password",
    "immediately",
    "unusual activity",
    "account suspension"
)

$detectedKeywords = @(
    foreach ($word in $keywords) {
        if ($email -match [regex]::Escape($word)) {
            $word
        }
    }
)

# 10. Identify suspicious indicators
$findings = @()

if ($domainMismatch) {
    $findings += "Sender and Reply-To domains do not match."
}

if ($urls.Count -gt 0) {
    $findings += "One or more URLs found in email."
}

if ($detectedKeywords.Count -gt 0) {
    $findings += "Suspicious urgency or account-related language detected."
}

if ($findings.Count -eq 0) {
    $findings += "No indicators detected by configured checks."
}

# 11. Generate initial assessment
$riskLevel = "Low"

if ($domainMismatch -or $urls.Count -gt 0) {
    $riskLevel = "Medium"
}

if ($domainMismatch -and $urls.Count -gt 0 -and
    $detectedKeywords.Count -gt 0) {
    $riskLevel = "High"
}

# 12. Create investigation report
$report = @"
AUTOMATED PHISHING EMAIL INVESTIGATION
======================================

INVESTIGATION DETAILS

Input file: $InputFile
Analysis date: $(Get-Date)

EMAIL INFORMATION

Sender: $sender
Reply-To: $replyTo
Subject: $subject

DOMAIN ANALYSIS

Sender domain: $senderDomain
Reply-To domain: $replyDomain
Domain mismatch: $domainMismatch

DETECTED KEYWORDS

$($detectedKeywords -join "`r`n")

EXTRACTED URLS

$($urls -join "`r`n")

INVESTIGATION FINDINGS

$($findings -join "`r`n")

INITIAL RISK ASSESSMENT

Risk level: $riskLevel

RECOMMENDED ACTIONS

- Do not click suspicious links.
- Do not provide account credentials.
- Verify sender identity through trusted channels.
- Investigate URLs using approved threat intelligence tools.
- Escalate suspicious emails to the security team.

CONCLUSION

The automated analysis identified suspicious indicators.
Manual investigation and threat intelligence verification
are required before reaching a final verdict.

DISCLAIMER

This tool performs basic heuristic analysis. It does not
authenticate email headers, prove sender spoofing, or
confirm that a URL is malicious.
"@

# 13. Save report
$reportPath = Join-Path $outputDir "Investigation-Report.txt"

$report | Out-File -FilePath $reportPath -Encoding utf8

# 14. Export indicators of compromise
$iocs = @()

if ($sender -ne "Not found") {
    $iocs += [PSCustomObject]@{
        Type = "Sender Email"
        Value = $sender
    }
}

if ($replyTo -ne "Not found") {
    $iocs += [PSCustomObject]@{
        Type = "Reply-To Email"
        Value = $replyTo
    }
}

if ($senderDomain -ne "Not available") {
    $iocs += [PSCustomObject]@{
        Type = "Sender Domain"
        Value = $senderDomain
    }
}

if ($replyDomain -ne "Not available") {
    $iocs += [PSCustomObject]@{
        Type = "Reply-To Domain"
        Value = $replyDomain
    }
}

foreach ($url in $urls) {
    $iocs += [PSCustomObject]@{
        Type = "URL"
        Value = $url
    }
}

$iocPath = Join-Path $outputDir "Extracted-IOCs.csv"

$iocs | Export-Csv -Path $iocPath -NoTypeInformation -Encoding UTF8

# 15. Display results
Write-Host ""
Write-Host "ANALYSIS COMPLETED" -ForegroundColor Green
Write-Host "Sender: $sender"
Write-Host "Reply-To: $replyTo"
Write-Host "Domain mismatch: $domainMismatch"
Write-Host "Extracted URLs: $($urls.Count)"
Write-Host "Detected keywords: $($detectedKeywords.Count)"
Write-Host "Initial risk level: $riskLevel" -ForegroundColor Yellow

Write-Host ""
Write-Host "REPORT: $reportPath" -ForegroundColor Green
Write-Host "IOCS:   $iocPath" -ForegroundColor Green

Write-Host ""
Write-Host "Investigation finished." -ForegroundColor Cyan
