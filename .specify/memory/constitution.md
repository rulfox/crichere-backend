<!--
SYNC IMPACT REPORT
- Version change: N/A → 1.0.0
- List of modified principles: All (initialized from template with 20 Crichere principles)
- Added sections: Technical Standards, Architecture & Regional Context
- Removed sections: None
- Templates requiring updates:
    - .specify/templates/plan-template.md (✅ checked)
    - .specify/templates/spec-template.md (✅ checked)
    - .specify/templates/tasks-template.md (✅ checked)
- Follow-up TODOs: None
-->

# Crichere Constitution

## Core Principles

### I. Authentication: Phone Number ONLY
Authentication is strictly limited to phone numbers via OTP. No passwords or other methods are permitted. Indian phone numbers must match the regex `^[6-9]\d{9}$`.
**Rationale**: Simplifies user experience for the target Indian market and ensures high security without password management overhead.

### II. Monetary Representation: Integer INR
All financial values must be stored and displayed as whole Indian Rupees (INR) using integer types. No decimals or paise are allowed.
**Rationale**: Avoids floating-point precision issues and aligns with common practice in Indian local auctions where smaller units are rarely used.

### III. Context-Scoped Roles
Roles are never global. They must exist only within membership tables: `UserPlatformMembership`, `UserLeagueMembership`, or `UserFranchiseMembership`.
**Rationale**: Ensures strict access control and flexibility as users can have different roles in different leagues or franchises.

### IV. Standardized API Responses
Every API response must use the standard envelope: `{ success, message, messageKey, data, error, timestamp }`. `messageKey` is mandatory for internationalization (i18n).
**Rationale**: Provides consistency for the frontend and supports future multi-language requirements.

### V. UUID Primary Keys
All primary keys must be UUIDs. Auto-incrementing integers are forbidden.
**Rationale**: Enhances security by preventing ID enumeration and simplifies data merging across distributed systems.

### VI. Real-Time Auction: Server-Sent Events (SSE)
Real-time auction updates must use SSE. WebSockets are strictly prohibited.
**Rationale**: SSE is lighter on resources, easier to implement through load balancers, and sufficient for the unidirectional nature of many auction updates.

### VII. Direct-to-S3 File Uploads
Files (photos, logos, PDFs) must never be uploaded through the backend. Use S3 presigned URLs for direct client uploads.
**Rationale**: Reduces backend load and improves scalability by offloading binary data handling to specialized storage services.

### VIII. Strict Layered Architecture (Backend)
The Spring Boot backend must follow a strict `Controller → Service → Repository` flow. Controllers must never call Repositories directly.
**Rationale**: Ensures separation of concerns and maintainability.

### IX. Clean Architecture & MVVM (Frontend)
The Flutter frontend must use a Clean Architecture + Feature-first hybrid with MVVM: `Widgets → ViewModels (Riverpod AsyncNotifier) → UseCases → Repository Interfaces → Data Sources`.
**Rationale**: Provides a testable, maintainable, and scalable frontend structure.

### X. Explicit Kotlin Inheritance
All Kotlin classes intended for inheritance must be marked `open` (e.g., `CrichereException`, `BusinessLogicException`). Kotlin classes are final by default.
**Rationale**: Adheres to Kotlin's "design for inheritance or prohibit it" philosophy, preventing unintended side effects.

### XI. Flyway Database Migrations
Database changes must use Flyway migrations with the naming convention: `V001__description.sql`.
**Rationale**: Ensures consistent database schema across all environments and enables reliable rollbacks.

### XII. String-Based Enums
Enums must be stored as `VARCHAR` using `@Enumerated(EnumType.STRING)`. Never use `ORDINAL`.
**Rationale**: Prevents data corruption if enum order changes and improves database readability.

### XIII. Regional Focus: India
The system is optimized for India: AWS Mumbai (`ap-south-1`), MSG91 for SMS, and strict Indian phone number validation.
**Rationale**: Minimizes latency and ensures compliance with local communication standards.

### XIV. Pluggable Notification Providers
All notification providers must be pluggable via `SmsProvider` and `PushProvider` interfaces. MSG91 is the default SMS implementation; FCM and APNs for push.
**Rationale**: Allows for easy switching of providers without affecting business logic.

### XV. Franchise Purse State
Franchise purse information must be stored as `FranchisePurseState` per franchise per round, not as a single field on the `Franchise` entity.
**Rationale**: Allows for historical tracking and multi-round auction logic.

### XVI. Append-Only Auction Audit Log
Every auction action must be logged in an append-only `AuctionAuditLog` with a monotonically increasing `sequenceNumber`.
**Rationale**: Critical for SSE event replay and maintaining a definitive record of all auction activities.

### XVII. Payment Gateway Stubs (V1)
Payments are free in V1. Razorpay integration is deferred to V2. Use stub entities for now.
**Rationale**: Speeds up initial launch while providing a path for future monetization.

### XVIII. RTM (Right to Match) Deferred (V2)
RTM functionality must not be implemented in V1.
**Rationale**: Simplifies the initial auction logic for faster time-to-market.

### XIX. League-Centric Hierarchy
The `League` is the top-level entity. The hierarchy is `League → Auction → Rounds`. There is no `Tournament` entity.
**Rationale**: Aligns the data model with the platform's focus on cricket leagues.

### XX. Global Player Profiles
`Player` is a global entity with one profile per phone number. Players can participate in multiple leagues without duplication.
**Rationale**: Ensures data integrity and allows for tracking player history across different leagues.

## Technical Standards

### Database & Storage
- PostgreSQL via Flyway migrations.
- S3 for all file storage via presigned URLs.
- Redis (optional) for SSE session management if needed.

### Communication
- REST API with standardized JSON envelope.
- SSE for real-time auction updates.
- MSG91 for OTP/SMS.

## Development Workflow

### Backend (Spring Boot / Kotlin)
- Layered architecture: Controller → Service → Repository.
- Strict Kotlin null-safety and open classes for inheritance.
- Standardized error handling with `messageKey`.

### Frontend (Flutter)
- Clean Architecture + MVVM.
- Riverpod for state management.
- Retrofit for API, Drift for local persistence.

## Governance
The Crichere Constitution supersedes all other informal practices. All development must align with these principles to ensure consistency, security, and scalability for the Indian market.

### Amendment Procedure
1. Propose changes via a "Constitution Amendment" PR.
2. Document the rationale and impact.
3. Upon approval, increment the version (MAJOR for removals/redefinitions, MINOR for new principles, PATCH for clarifications).
4. Update all dependent templates and guidance.

**Version**: 1.0.0 | **Ratified**: 2026-04-24 | **Last Amended**: 2026-04-24
