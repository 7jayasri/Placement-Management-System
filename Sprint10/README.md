# Engineering Sprint 10 – Student Placement Portal

## 📌 Overview

Sprint 10 focuses on building **Lightning Web Components (LWC)** that work together as a coordinated application rather than as isolated components.

The Student Placement Portal demonstrates:

- Parent-to-child communication
- Child-to-parent communication using custom events
- Lightning Base Components
- Student Profile form
- Client-side validation
- Server-side validation
- Apex integration
- Lightning Data Service concepts
- Reactive data and refresh behaviour
- Reusable components
- Loading, Success, Empty and Error states
- Clear component responsibilities
- Testing and architecture best practices

---

## 🏗️ Project Architecture

The portal is organized into focused components with clear responsibilities.

```text
StudentPortal
│
├── StudentSummary
├── StudentProfile
├── EligibleJobs
│   └── JobCard
├── MyApplications
│   └── ApplicationCard
└── OfferSummary
```
1. Parent-to-Child Communication

Parent-to-child communication is used when a parent component owns information that a child component needs.

In LWC, the parent passes data to the child through a public property using @api.

2. Child-to-Parent Communication

A child component communicates with its parent using a Custom Event.

The child reports what happened, while the parent decides what should happen next.
