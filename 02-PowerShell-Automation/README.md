
# PowerShell Phishing Email Analysis

## Objective

The purpose of this script is to automate the initial analysis of a suspicious email

The script reads the simulated phishing email and extracts information that can assist with an initial security investigation

## Script

`analyze-phishingemail.ps1`

## Functions

The script performs the following tasks:

- Checks that the input email file exists
- Extracts the sender email address
- Extracts the Reply-To email address
- Identifies sender and Reply-To domain mismatches
- Extracts URLs from the email
- Detects predefined suspicious keywords
- Identifies suspicious indicators
- Assigns an initial heuristic risk level
- Generates an investigation report
- Exports extracted indicators to a CSV file

## Generated Output

The script generates:

- `Output/Investigation-Report.txt`
- `Output/Extracted-IOCs.csv`

## Execution

Run the script from the project directory using PowerShell:

```powershell
.\02-PowerShell-Automation\analyze-phishingemail.ps1
```

## Observed Results

The script completed successfully and reported:

- Domain mismatch: True
- Extracted URLs: 1
- Detected keywords: 6
- Initial risk level: High

## Conclusion

The automation demonstrated how PowerShell can assist with initial phishing email analysis by extracting useful information and generating investigation output
