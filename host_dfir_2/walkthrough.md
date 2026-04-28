# Host DFIR Scenario 2: SIEM Analysis (Resource Hijacking & Cloud Breach)

## Background
As a SOC (Security Operations Center) Analyst, you've been alerted to unusual billing spikes and potential resource hijacking in the company's cloud environment. You have access to **Splunk**, which aggregates logs from all hosts and cloud services (AWS).  Your goal is to use Splunk to identify a process suspected of unauthorized cryptomining and investigate a potential data breach involving an exposed storage bucket.

## Instructions

### 1. Accessing Splunk
1. Open a web browser and go to `http://localhost:8000`.
2. Log in with the following credentials:
   - **Username:** `admin`
   - **Password:** `CareerFair2026!`
3. Click on **Search & Reporting** on the left side.

### 2. Initial Data Overview
To see all the data available in the dataset, set the time picker to **All Time** and then enter the following query:
```spl
index=botsv3 earliest=0
```

### 3. An Exposed Bucket 
Sometimes misconfigurations can lead to sensitive storage services being exposed to the public.  Use the following query to find the `bucketName` that was made public.
```spl
index=botsv3 earliest=0 bstoll eventName=putbucketacl
```

### 4. Someone Noticed!
Cloud storage buckets (S3) are common targets. If misconfigured, attackers can upload malicious files or exfiltrate data. Let's look for a file uploaded from a helpful individual highlighting this issue. Use the following query to find the name of the file uploaded to the public bucket.
```spl
index=botsv3 earliest=0 frothlywebcode "*.txt" *PUT*
```

### 5. Auditing User Security (MFA)
Identifying the IPv4 address the attacker used to login without having to use MFA.  The query below shows a specific, unusual IPv4 address that is uncommon.
```spl
index=botsv3 sourcetype="aws:cloudtrail" "additionalEventData.MFAUsed"=No | table eventName, userIdentity.userName, sourceIPAddress
```

### 6. Mining Coins
A Frothly endpoint exhibits signs of coin mining activity. Let's see if we can find the first process to reach 100 percent CPU processor utilization time from this activity using the following query.
```spl
index=botsv3 sourcetype="perfmonmk:process" "%_Processor_Time"=100 NOT (instance="Idle" OR instance="_Total" OR instance="MicrosoftEdgeCP*") | sort _time
```

### 7. Summary of Findings
Using the SIEM, you've identified a rogue process hijacking system resources and traced an unauthorized cloud storage modification back to an account lacking proper MFA protections.
