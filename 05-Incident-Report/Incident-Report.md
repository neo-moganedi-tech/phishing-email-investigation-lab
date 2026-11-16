
# Phishing Email Investigation Report

## 1. Executive Summary

A simulated phishing email was analysed to identify suspicious characteristics and potential indicators of compromise

PowerShell was used to automate the initial analysis and extract relevant email information. The extracted URL was also reviewed using urlscan.io

The automated analysis assigned an initial risk level of High

## 2. Incident Overview

**Incident Type:** Simulated phishing email

**Investigation Method:** Manual email inspection and PowerShell automation

**Tools Used:**
- Windows PowerShell
- Visual Studio Code
- urlscan.io

## 3. Investigation Activities

The investigation included:

1. Reviewing the simulated email content
2. Examining the sender and Reply-To addresses
3. Identifying a domain mismatch
4. Extracting the URL from the email
5. Detecting suspicious keywords
6. Generating an investigation report and IOC CSV file using PowerShell
7. Reviewing the extracted URL using urlscan.io

## 4. Technical Findings

The PowerShell script reported:

| Finding | Result |
|---|---|
| Sender | security@microsoft-support.invalid |
| Reply-To | account-recovery@outlook-security.invalid |
| Domain mismatch | True |
| Extracted URLs | 1 |
| Detected keywords | 6 |
| Initial risk level | High |

The email contained urgency-based language and requested immediate account verification

## 5. URL Investigation

The extracted URL was:

`https://microsoft-login-verify.invalid/account`

The urlscan.io lookup displayed no existing scan record for the hostname or URL

No malicious verdict was available from the displayed results

The `.invalid` domain is reserved and was used for simulation. Therefore, this result cannot establish the safety or maliciousness of a real website

## 6. Risk Assessment

**Initial Risk Level: High**

The automated assessment was based on the detected domain mismatch, URL and suspicious keywords

This is a heuristic result from the script and should not be interpreted as confirmation of a real compromise

## 7. Security Recommendations

- Avoid clicking links in suspicious emails
- Never enter credentials through unverified links
- Report suspected phishing emails to the appropriate security team
- Review sender and Reply-To information carefully
- Investigate suspicious URLs using approved threat intelligence tools
- Use appropriate email filtering and authentication controls

## 8. Conclusion

The investigation demonstrated how PowerShell can automate parts of an initial phishing email investigation

The script successfully extracted email addresses, domains and URLs, detected suspicious keywords, assigned an initial risk rating and generated output files

The URL investigation also demonstrated the importance of interpreting threat intelligence results carefully
