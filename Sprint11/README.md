# Sprint 11 – Recruitment API Integration using Queueable Apex

## Overview

Sprint 11 focuses on integrating the Salesforce Placement Management System with an external Recruitment API.

In this sprint, I implemented an asynchronous integration using Queueable Apex. The integration sends candidate information from Salesforce to an external Recruitment API using an HTTP POST request. A Named Credential is used to manage the external service connection, while a Permission Set and External Credential Principal are used to control access.

The integration also records the result of the API operation on the Salesforce Application record.

---

## Objectives

- Integrate Salesforce with an external Recruitment API.
- Implement asynchronous processing using Queueable Apex.
- Perform HTTP callouts from Queueable Apex.
- Use `Database.AllowsCallouts`.
- Configure and use a Named Credential.
- Use External Credential access controls.
- Use a Permission Set for integration access.
- Send candidate information as JSON.
- Process API responses.
- Store the external candidate ID.
- Track integration status and errors.
- Verify the integration using Developer Console logs.

---

## Key Concepts

### 1. External API Integration

An API allows Salesforce to communicate with an external system and exchange information.

In this project, Salesforce sends candidate information to an external Recruitment API.

### 2. HTTP Callout

An HTTP callout is a request sent from Salesforce to an external web service.

The integration uses an HTTP `POST` request to send candidate information.

### 3. Queueable Apex

Queueable Apex is used to execute the integration asynchronously in the background.

The main integration class is:

4. Database.AllowsCallouts

The Queueable class implements:
Database.AllowsCallouts

5. Named Credential

The integration uses the Named Credential:Recruitment API Credential
The Named Credential stores the external service configuration instead of hard-coding the endpoint or authentication details inside Apex.

6. Permission Set
The :Recruitment API Access
Permission Set provides the required access to the external credential principal.

7. JSON

Candidate information is converted into JSON before it is sent to the external API.
JSON serialization is used to convert Apex data into the request body.

Integration Architecture
Application Record
        |
        v
CandidateSyncQueueable
        |
        v
HTTP Request
        |
        v
Named Credential
        |
        v
Recruitment API
        |
        v
Process Response
        |
        +----------------------+
        |                      |
     Success                 Failure
        |                      |
        v                      v
Integration Status       Integration Status
     = Sent                  = Failed
        |                      |
        v                      v
External Candidate       Integration Error
       Id
