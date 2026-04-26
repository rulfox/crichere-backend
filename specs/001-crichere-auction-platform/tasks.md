# Tasks: Crichere Auction Platform

**Input**: Design documents from `/specs/001-crichere-auction-platform/`
**Prerequisites**: plan.md (required), spec.md (required), data-model.md, contracts/api.md

## Phase 1: Setup (Shared Infrastructure)

- [x] T001 Initialize Spring Boot backend project in `crichere-backend/`
- [x] T002 [P] Initialize Flutter frontend project in `crichere-flutter/`
- [x] T003 [P] Configure backend Flyway and PostgreSQL connection
- [x] T004 [P] Configure frontend Riverpod, Dio, and Drift dependencies
- [x] T005 [P] Create backend module structure

---

## Phase 2: Foundational (Blocking Prerequisites)

- [x] T006 Implement JWT Authentication Filter and security configuration
- [x] T007 [P] Implement `ResponseHelper` and standard error envelope
- [x] T008 [P] Implement pluggable `SmsProvider` and `PushProvider` interfaces
- [x] T009 Create `User` and `OTP` entities and repositories
- [x] T010 Implement S3 presigned URL service
- [x] T011 [P] Setup frontend Clean Architecture folders
- [x] T012 [P] Implement frontend JWT secure storage and Dio interceptors

---

## Phase 3: User Story 1 - League Configuration (Priority: P1)

- [x] T013 [US1] Create `League` and `LeaguePlayer` entities
- [x] T014 [US1] Implement `LeagueService` logic
- [x] T015 [US1] Implement Bulk CSV Player Import
- [x] T016 [US1] Create `LeagueController`
- [x] T044 [P] [US1] Unit test `LeagueService` base price resolution logic
- [x] T017 [P] [US1] Create frontend League feature module
- [x] T018 [P] [US1] Implement frontend League creation form (Admin only)

---

## Phase 4: User Story 2 - Real-Time Auction (Priority: P1)

- [x] T019 [US2] Create `Auction`, `Bid`, and `AuctionAuditLog` entities
- [x] T020 [US2] Implement `SseBroadcaster` using Redis pub/sub
- [x] T021 [US2] Implement `AuctionService` state machine
- [x] T022 [US2] Implement Auctioneer bid recording and "Undo" logic
- [x] T023 [US2] Implement `GET /auctions/{id}/events` SSE stream
- [x] T024 [P] [US2] Implement frontend SSE client with state sync logic
- [x] T025 [P] [US2] Build frontend Auctioneer Panel (Web) and Viewer Dashboard (Mobile)
- [x] T042 [US2] Implement Player Pre-assignment logic
- [x] T043 [US2] Implement League Admin Force-Assign logic

---

## Phase 5: User Story 3 - Player Registration & Ghost Claiming (Priority: P1)

- [x] T026 [US3] Implement `POST /api/v1/auth/profile/claim` endpoint
- [x] T027 [US3] Implement logic to auto-link `LeaguePlayer` records
- [x] T028 [P] [US3] Create frontend Player feature module
- [x] T029 [US3] Implement frontend Profile Claiming flow (OTP input + Style/Role)

---

## Phase 6: User Story 4 - Fee and Forfeit Management (Priority: P2)

- [x] T030 [US4] Create `FeeObligation`, `ForfeitRequest`, and `WaitingList` entities
- [x] T031 [US4] Implement `ForfeitService` rules
- [x] T032 [US4] Implement `WaitingList` auto-shifting
- [x] T033 [US4] Implement backend Fee collection summary reporting
- [x] T034 [P] [US4] Implement frontend Fee and Forfeit management placeholders

---

## Phase 7: Polish & Cross-Cutting Concerns

- [x] T035 [P] Implement backend PDF generation
- [x] T036 [P] Implement frontend shareable squad image/PDF export
- [x] T037 [P] Configure FCM messaging and NotificationService
- [x] T038 [P] Final UI/UX polish: Lottie, Shimmer, Shortcuts, and Semantics
- [ ] T039 [P] Setup SSE load-test harness
- [ ] T040 [P] Perform Redis pub/sub benchmark
- [ ] T041 Validate platform scaling

---

## Bug-Fix Pass (post-review, 2026-04-25)

- [x] T045-T054 All backend correctness fixes applied and verified.

## Bug-Fix Pass (Frontend & Architectural Refinements, 2026-04-25)

- [x] T055 [P] Fix DropdownButtonFormField initial value and FilePicker static usage.
- [x] T056 [P] Switch to SharePlus for improved squad export.
- [x] T057 [P] Refine SSE state sync logic in auctionEvents provider.
- [x] T058 [P] Add context.mounted checks to async navigation/UI logic.
- [x] T059 [P] Enable core library desugaring in Android build.gradle.kts.
- [x] T060 [P] Standardize Freezed entities with abstract keyword.

## Web Support Implementation (2026-04-25)

- [x] T061 [P] Implement conditional database connection for Web (Wasm SQLite).
- [x] T062 [P] Configure NotificationService to handle Web platform constraints.
- [x] T063 [P] Add sqlite3.wasm to web directory for drift compatibility.

## iOS Support Implementation (2026-04-25)

- [x] T064 [P] Configure CocoaPods and Podfile for iOS dependencies.
- [x] T065 [P] Update IPHONEOS_DEPLOYMENT_TARGET to 15.0 in project.pbxproj.
- [x] T066 [P] Integrate Pods framework into Xcode workspace and project configurations.
\n## Backend Dependency Maintenance (2026-04-26)\n\n- [x] T067 Upgrade backend dependencies (Spring Boot 3.5.9, Kotlin 2.3.21, JJWT 0.13.0, etc.)
- [x] T068 Externalize production settings to environment variables and add .env.example
