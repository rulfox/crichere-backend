# Implementation Plan: Crichere Auction Platform

**Branch**: `001-crichere-auction-platform` | **Date**: 2026-04-24 | **Spec**: [specs/001-crichere-auction-platform/spec.md](spec.md)
**Input**: Feature specification from `/specs/001-crichere-auction-platform/spec.md`

## Status (Updated 2026-04-26)
Backend dependency upgrades applied (Spring Boot 3.5.9, Kotlin 2.3.21, and various libraries). Previous: 
Frontend architectural refinements, bug fixes, Flutter Web support (Wasm SQLite), and iOS (CocoaPods) support applied. SSE state sync improved and build issues resolved.

## Summary
Build "Crichere", an India-first cricket league auction SaaS platform. The implementation involves a Spring Boot (Kotlin) backend and a Flutter frontend. The platform features real-time verbal auction recording by an auctioneer, SSE-based live updates, strict phone-OTP authentication, and comprehensive league management including fees and waiting lists.

## Technical Context

**Language/Version**: Kotlin 2.3.21 (Backend), Dart (Flutter Stable)  
**Primary Dependencies**: 
- **Backend**: Spring Boot 3.5.9, Spring Security, Spring Data JPA, Spring Data Redis (SSE pub/sub), AWS SDK v2 (S3), MSG91 (SMS), FCM (Push), ShedLock, Flyway, JJWT.
- **Frontend**: Riverpod (State Management), Dio + Retrofit (API), Drift (Local DB), auto_route (Navigation), Freezed (Serialization), eventsource (SSE).
**Storage**: PostgreSQL 16 (RDS/Managed), Redis (ElastiCache/Managed), AWS S3 (ap-south-1 Mumbai region).  
**Testing**: JUnit 5, MockK, Testcontainers (PostgreSQL).  
**Target Platform**: Android (Primary), iOS, Web (Single Flutter codebase).
**Project Type**: SaaS Mobile/Web Platform.  
**Performance Goals**: < 500ms SSE latency, supports 5,000 concurrent viewers per auction.  
**Constraints**: 
- Phone-only authentication (OTP).
- Whole INR integer money representation.
- Strict layered architecture (Backend) and Clean Architecture (Frontend).
- Direct-to-S3 file upload flow.
- Online-only auction bidding.
**Scale/Scope**: Target 50 concurrently active auctions platform-wide for V1.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Validation |
|-----------|--------|------------|
| I. Auth: Phone ONLY | ✅ | Spec FR-001/002 and tech context confirm OTP-only. |
| II. Money: Integer INR | ✅ | Spec FR-006 and constitution mandate integer INR. |
| III. Context Roles | ✅ | Spec membership tables (UserLeagueMembership, etc.) follow this. |
| IV. Standard Response | ✅ | Constitution and tech context mandate standard envelope with `messageKey`. |
| V. UUID PKs | ✅ | Constitution and database conventions mandate UUIDs. |
| VI. SSE Real-time | ✅ | Spec FR-005 and constitution mandate SSE via Redis pub/sub. |
| VII. Direct-to-S3 | ✅ | Spec FR-018 and constitution mandate presigned URL flow. |
| VIII. Strict Layers (BE) | ✅ | Constitution and backend architecture mandate Controller → Service → Repository. |
| IX. Clean Arch (FE) | ✅ | Constitution and frontend architecture mandate MVVM + Feature-first Clean Arch. |
| X. Open Kotlin Classes | ✅ | Constitution mandates `open` for inheritance-ready classes. |
| XI. Flyway Migrations | ✅ | Spec FR-011 and constitution mandate Flyway with VXXX naming. |
| XII. String Enums | ✅ | Constitution mandates String enumeration in DB. |
| XIII. Region: India | ✅ | Constitution and spec assumptions mandate ap-south-1 and MSG91. |
| XIV. Pluggable Providers | ✅ | Constitution mandates pluggable SmsProvider and PushProvider. |
| XV. Purse State | ✅ | Spec FranchisePurseState follows per-round state requirement. |
| XVI. Auction Audit Log | ✅ | Spec FR-004 and constitution mandate append-only monotonic log. |
| XVII. Payments V1 Free | ✅ | Spec Assumptions and constitution confirm V1 cash/free only. |
| XVIII. RTM Deferred | ✅ | Constitution mandates no RTM in V1. |
| XIX. League Hierarchy | ✅ | Constitution mandates League → Auction → Rounds. |
| XX. Global Player | ✅ | Spec Player entity and constitution confirm global phone-based identity. |

## Project Structure

### Documentation (this feature)

```text
specs/001-crichere-auction-platform/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
└── tasks.md             # Phase 2 output
```

### Source Code (repository root)

```text
crichere-backend/         # Spring Boot project
├── src/main/kotlin/
│   ├── common/           # Shared utilities, exceptions, security
│   └── domain/           # Domain modules (auth, player, league, etc.)
└── src/main/resources/db/migration/ # Flyway scripts

crichere-flutter/         # Flutter project
├── lib/
│   ├── core/             # Base infrastructure
│   ├── features/         # Feature modules (Clean Arch)
│   └── shared/           # Common widgets
```

**Structure Decision**: Multi-project repository with distinct backend and frontend directories as specified in the technical context.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |
