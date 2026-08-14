## Sprint 12 – Deployment and Version Control

This project uses Salesforce DX source format and Git for version control.

### Development Workflow

1. Salesforce metadata is maintained in the local Salesforce DX project.
2. Changes are developed and tested locally.
3. Git is used to track source changes.
4. Feature branches are used for development.
5. Changes are committed with meaningful commit messages.
6. Changes are pushed to GitHub.
7. Pull Requests are used for review before merging.

### Project Structure

- `force-app/main/default` – Salesforce metadata
- `config` – Salesforce project configuration
- `scripts` – development scripts
- `README.md` – project documentation

### Deployment

Salesforce CLI is used to authenticate orgs, validate deployments, deploy metadata and run tests.

### Testing

The project contains Apex/LWC test assets and should be validated before deployment.

### Security

Security is implemented using Salesforce access-control mechanisms including Profiles, Permission Sets, Object permissions, Field-Level Security, record-level sharing and secure Apex practices.
