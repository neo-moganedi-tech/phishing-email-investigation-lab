
# URL Investigation

## Objective

Investigate the URL extracted from the simulated phishing email using urlscan.io

## Extracted URL

`https://microsoft-login-verify.invalid/account`

## Tool Used

[urlscan.io](https://urlscan.io/)

## Investigation Process

1. Extracted the URL from the simulated phishing email
2. Opened urlscan.i
3. Entered the extracted URL into the URL search field
4. Reviewed the information displayed by the platform

## Observed Results

The urlscan.io page displayed:

- Hostname age: Never seen
- Hostname: Never scanned
- URL: Never scanned
- Malicious verdicts: No existing malicious verdicts displayed

## Analysis

The platform did not have an existing scan record for the hostname or URL

The absence of a malicious verdict does not establish that a URL is safe

The URL uses the reserved `.invalid` domain, so it does not represent a real website
