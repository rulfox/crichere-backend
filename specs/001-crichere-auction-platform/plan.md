# Implementation Plan: Crichere Auction Platform

**Branch**: `001-crichere-auction-platform` | **Date**: 2026-04-24 | **Spec**: [specs/001-crichere-auction-platform/spec.md](spec.md)
**Input**: Feature specification from `/specs/001-crichere-auction-platform/spec.md`

## Status (Updated 2026-05-16)

### Flutter dependency stack upgraded & Docker build fixed
Upgraded Flutter SDK from 3.38.1 → **3.41.9** (Dart 3.11.5). The old SDK pinned `test_api 0.7.7` which capped the Dart analyzer at `<9.0.0`, blocking all modern package versions. Flutter 3.41.9 pins `test_api 0.7.10`, lifting the ceiling to `<11.0.0` and unlocking:
- `auto_route 11.1.0`, `auto_route_generator 10.5.0`
- `riverpod_generator 4.0.3`, `riverpod_annotation 4.0.2`, `flutter_riverpod / hooks_riverpod 3.3.1`
- `freezed 3.2.5`, `retrofit_generator 10.2.6`, `google_fonts 8.1.0`

**eventsource package removed** — abandoned (stuck on http ^0.13.3), replaced with native Dio streaming (`ResponseType.stream`) for SSE in `auction_provider.dart`.

Docker web build fixes applied:
- Base image updated to `ghcr.io/cirruslabs/flutter:3.41.9`
- `--web-renderer=html` removed (dropped in Flutter 3.29)
- `--no-wasm-dry-run` added to bypass dart2wasm feasibility check that fails under Docker seccomp
- `.dockerignore` created — excludes `.dart_tool/` to prevent host machine absolute paths contaminating the container build

### Flutter UI audit — all screens reviewed and fixed
Full audit of all 18 screens. Key fixes applied:
- **Web splash** — cricket ball SVG + gold spinner shown while Flutter initialises (eliminates white screen flash); fades out on first frame event
- **Branding** — `index.html` title and `manifest.json` updated to "Crichere", theme `#F59E0B`, background `#060C1A`
- **OTP resend** — now calls `sendOtpUseCase` and restarts 5-min timer; shows spinner during resend
- **Profile setup** — wired to `updateCricketProfile` API before navigating home
- **Pre-assignment** — player taps now call `auctionRepo.preAssign()` and reflect in UI immediately
- **Home screen** — AUCTION→AuctioneerPanel, EDIT→LeagueDetail, fee alert VIEW→FeeManagement; LIVE NOW banner uses real live league from API
- **League detail** — SHARE uses `share_plus`, REGISTER AS PLAYER calls `joinWaitlist`; description and creator shown from API data
- **Post-auction exports** — PDF generated via `pdf` package and shared; share link copies + shares via `share_plus`; Excel/image show informative snackbars
- **Platform admin** — MANAGE→LeagueDetailRoute, SUSPEND→`suspendLeague` API; empty state added
- **Franchise squad** — invite link uses real `franchiseId`; empty state added for 0 players
- **Notifications** — timestamps use real `receivedAt` field with relative formatting ("2h ago", "3d ago")
- **CricErrorView** — new shared widget with icon + message + retry; replaces all bare `Text('Error: $e')` in key screens

Previous: Aligned Auth flow with backend API: separate OTP send/verify endpoints, updated AuthRepository, and expanded request models. Expanded API contract documentation in api.md (2026-04-27). Optimistic locking, token blacklisting, standard response filtering, metrics, and Dockerization applied (2026-04-26). Frontend architectural refinements and platform support (Web/iOS) applied (2026-04-25).

## Summary
Build "Crichere", an India-first cricket league auction SaaS platform. The implementation involves a Spring Boot (Kotlin) backend and a Flutter frontend. The platform features real-time verbal auction recording by an auctioneer, SSE-based live updates, strict phone-OTP authentication, and comprehensive league management including fees and waiting lists.

## Technical Context

**Language/Version**: Kotlin 2.3.21 (Backend), Dart (Flutter Stable)  
**Primary Dependencies**: 
- **Backend**: Spring Boot 3.5.9, Spring Security, Spring Data JPA, Spring Data Redis (SSE pub/sub), AWS SDK v2 (S3), MSG91 (SMS), FCM (Push), ShedLock, Flyway, JJWT.
- **Frontend**: Riverpod (State Management), Dio + Retrofit (API), Drift (Local DB), auto_route (Navigation), Freezed (Serialization), Dio streaming (SSE — eventsource removed as abandoned).
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
