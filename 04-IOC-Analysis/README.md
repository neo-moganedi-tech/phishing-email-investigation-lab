
# Indicator of Compromise (IOC) Analysis

## Objective

Identify and document potential indicators of compromise extracted from the simulated phishing email

## Extracted Indicators

| Indicator Type | Value |
|---|---|
| Sender Email | security@microsoft-support.invalid |
| Reply-To Email | account-recovery@outlook-security.invalid |
| Sender Domain | microsoft-support.invalid |
| Reply-To Domain | outlook-security.invalid |
| Suspicious URL | https://microsoft-login-verify.invalid/account |

## Analysis

The sender and Reply-To addresses use different domains

The sender domain contains Microsoft-related wording, while the Reply-To domain is different

The email also contains a URL that uses Microsoft-related wording and urgency-based language requesting immediate account verification

These characteristics are suspicious and require further investigation

## Security Recommendations

1. Do not click suspicious links
2. Do not submit credentials through unverified websites
3. Report suspected phishing emails to the security team
4. Investigate suspicious indicators using approved security tools
5. Apply appropriate email security and filtering controls
