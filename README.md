
# Phishing Email Investigation Lab

## Overview

This project demonstrates a hands-on investigation of a simulated phishing email using PowerShell automation, indicator of compromise (IOC) extraction and threat intelligence research

The objective was to identify suspicious characteristics in an email, automate the extraction of relevant indicators and document the investigation findings

## Objectives

- Analyse a simulated phishing email
- Examine sender and Reply-To email addresses
- Identify suspicious domain mismatches
- Extract URLs and potential indicators of compromise
- Use PowerShell to automate initial email analysis
- Investigate a suspicious URL using urlscan.io
- Document findings and security recommendations

## Tools Used

- Windows PowerShell
- Visual Studio Code
- urlscan.io
- GitHub

## Investigation Workflow

1. Created a simulated phishing email for analysis
2. Examined the sender address, Reply-To address, subject and email content
3. Developed a PowerShell script to automate the initial analysis
4. Executed the script to extract email addresses, domains, URLs and suspicious keywords
5. Generated an investigation report and an IOC CSV file
6. Checked the suspicious URL using urlscan.io
7. Documented the investigation findings

## Automated Analysis Results

The PowerShell script reported:

| Finding | Result |
|---|---|
| Domain mismatch | True |
| Extracted URLs | 1 |
| Detected keywords | 6 |
| Initial risk level | High |

The high-risk rating is a heuristic assessment based on the script's detection rules

## URL Investigation

The extracted URL was checked using urlscan.io

The displayed results indicated that the hostname and URL had never been scanned. No existing scan record or malicious verdict was available

The URL uses the reserved `.invalid` domain and is part of this simulated exercise

## Key Learning Outcomes

- Understanding common phishing email characteristics
- Identifying sender and Reply-To domain mismatches
- Using PowerShell for basic security investigation automation
- Extracting and documenting indicators of compromise
- Using threat intelligence platforms to research URLs
- Writing investigation findings and security recommendations

## Disclaimer

This project is intended for educational purposes only

The email addresses, domains and URL used in the exercise are simulated. The `.invalid` domain is reserved for invalid domain names, and no real phishing website or infrastructure was created
