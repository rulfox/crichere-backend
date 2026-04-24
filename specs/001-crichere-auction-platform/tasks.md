# Tasks: Crichere Auction Platform

**Input**: Design documents from `/specs/001-crichere-auction-platform/`
**Prerequisites**: plan.md (required), spec.md (required), data-model.md, contracts/api.md

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic directory structure for backend and frontend

- [ ] T001 Initialize Spring Boot backend project in `crichere-backend/` with Kotlin DSL
- [ ] T002 [P] Initialize Flutter frontend project in `crichere-flutter/`
- [ ] T003 [P] Configure backend Flyway and PostgreSQL connection in `crichere-backend/src/main/resources/application.yml`
- [ ] T004 [P] Configure frontend Riverpod, Dio, and Drift dependencies in `crichere-flutter/pubspec.yaml`
- [ ] T005 [P] Create backend module structure: `domain/<module>/{entity, repository, service, controller, dto}`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core security, authentication, and communication infrastructure

- [ ] T006 Implement JWT Authentication Filter and security configuration in `crichere-backend/src/main/kotlin/common/security/`
- [ ] T007 [P] Implement `ResponseHelper` and standard error envelope in `crichere-backend/src/main/kotlin/common/response/`
- [ ] T008 [P] Implement pluggable `SmsProvider` (MSG91) and `PushProvider` (FCM) interfaces in `crichere-backend/src/main/kotlin/common/provider/`
- [ ] T009 Create `User` and `OTP` entities and repositories in `crichere-backend/src/main/kotlin/domain/auth/`
- [ ] T010 Implement S3 presigned URL service in `crichere-backend/src/main/kotlin/common/service/S3Service.kt`
- [ ] T011 [P] Setup frontend Clean Architecture folders in `crichere-flutter/lib/` (core, features, shared)
- [ ] T012 [P] Implement frontend JWT secure storage and Dio interceptors in `crichere-flutter/lib/core/network/`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - League Configuration (Priority: P1)

**Goal**: Enable League Admins to create and configure leagues with full rules and player imports

**Independent Test**: Admin creates a league and imports players via CSV. Verification: League and players appear in backend DB and frontend list.

- [ ] T013 [US1] Create `League` and `LeaguePlayer` entities and Flyway migration `V004__create_league_tables.sql`
- [ ] T014 [US1] Implement `LeagueService` with status transition logic and base price resolution in `crichere-backend/src/main/kotlin/domain/league/`
- [ ] T015 [US1] Implement Bulk CSV Player Import with ghost profile creation in `crichere-backend/src/main/kotlin/domain/league/BulkImportService.kt`
- [ ] T016 [US1] Create `LeagueController` with endpoints for creation and config update
- [ ] T017 [P] [US1] Create frontend League feature module (data, domain, presentation) in `crichere-flutter/lib/features/league/`
- [ ] T018 [US1] Implement frontend League creation form and CSV upload logic

---

## Phase 4: User Story 2 - Real-Time Auction (Priority: P1)

**Goal**: Conduct a live auction with real-time SSE updates and auctioneer controls

**Independent Test**: Auctioneer records a bid. Verification: All connected viewers receive the `BidPlaced` SSE event within 500ms.

- [ ] T019 [US2] Create `Auction`, `Bid`, and `AuctionAuditLog` entities and Flyway migration `V006__create_auction_tables.sql`
- [ ] T020 [US2] Implement `SseBroadcaster` using Redis pub/sub for cross-instance event distribution in `crichere-backend/src/main/kotlin/domain/auction/`
- [ ] T021 [US2] Implement `AuctionService` with state machine transitions (DRAFT -> LIVE -> PAUSED)
- [ ] T022 [US2] Implement Auctioneer bid recording and "Undo" logic with mandatory reasons
- [ ] T023 [US2] Implement `GET /auctions/{id}/events` SSE stream with `Last-Event-ID` replay logic
- [ ] T024 [P] [US2] Implement frontend SSE client using `eventsource` and Riverpod `StreamProvider` in `crichere-flutter/lib/features/auction/`
- [ ] T025 [US2] Build frontend Auctioneer Panel (Web) and Viewer Dashboard (Mobile)

---

## Phase 5: User Story 3 - Player Registration & Ghost Claiming (Priority: P1)

**Goal**: Allow players to claim their pre-created profiles via OTP verification

**Independent Test**: User enters phone, verifies OTP. Verification: Profile status changes from `GHOST` to `ACTIVE` and `claimedAt` is set.

- [ ] T026 [US3] Implement `POST /api/v1/auth/profile/claim` endpoint in `crichere-backend/src/main/kotlin/domain/auth/`
- [ ] T027 [US3] Implement logic to auto-link all existing `LeaguePlayer` records to the claiming `User`
- [ ] T028 [P] [US3] Create frontend Player feature module in `crichere-flutter/lib/features/player/`
- [ ] T029 [US3] Implement frontend Profile Claiming flow (OTP input + Style configuration)

---

## Phase 6: User Story 4 - Fee and Forfeit Management (Priority: P2)

**Goal**: Manage financial obligations and automated waiting list promotions

**Independent Test**: Admin approves a forfeit. Verification: Next player in waiting list is automatically promoted in `AUTO_PROMOTE` mode.

- [ ] T030 [US4] Create `FeeObligation`, `ForfeitRequest`, and `WaitingList` entities and Flyway migrations `V007`, `V008`, `V009`
- [ ] T031 [US4] Implement `ForfeitService` with `feeRefundDecision` rules and `AUTO_PROMOTE` logic
- [ ] T032 [US4] Implement `WaitingList` position auto-shifting on promotion or withdrawal
- [ ] T033 [US4] Implement backend Fee collection summary reporting
- [ ] T034 [P] [US4] Implement frontend Fee and Forfeit management screens in `crichere-flutter/lib/features/fee/`

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Global exports, notifications, and final UI refinements

- [ ] T035 [P] Implement backend PDF generation for squad summaries using iText/PDFBox
- [ ] T036 Implement frontend shareable squad image capture using `screenshot` package
- [ ] T037 [P] Configure FCM background message handling in `crichere-flutter/lib/core/notification/`
- [ ] T038 Final UI/UX polish: Lottie animations and Shimmer loading states
- [ ] T039 [P] Setup SSE load-test harness (JMeter/Gatling) targeting 5,000 viewers/auction
- [ ] T040 [P] Perform Redis pub/sub benchmark for cross-instance latency validation
- [ ] T041 Validate platform scaling to 50 simultaneous auctions (250k total connections)

---

## Dependencies & Execution Order

### Phase Dependencies
1. **Setup (Phase 1)**: Must complete first.
2. **Foundational (Phase 2)**: Must complete before any functional story starts.
3. **User Stories (Phases 3-5)**: P1 stories can proceed in parallel once Foundation is ready.
4. **User Stories (Phase 6)**: P2 story depends on League (US1) and Player (US3) being stable.
5. **Polish (Phase 7)**: Depends on all user stories being functionally complete.

### Implementation Strategy
- **MVP**: Complete Phases 1, 2, and 3 to have a working league management system with player imports.
- **Incremental**: Add Real-Time Auction (Phase 4) next as the core value prop, followed by user identity (Phase 5) and administrative workflows (Phase 6).

---

## Parallel Execution Examples

### User Story 1 (League Config)
```bash
# Developer A: Backend Entity and Service
Task: "Create League and LeaguePlayer entities in domain/league/"
Task: "Implement Bulk CSV Player Import logic"

# Developer B: Frontend Feature Setup
Task: "Create frontend League feature module"
Task: "Implement frontend League creation form"
```

### User Story 2 (Auction)
```bash
# Developer A: SSE Engine and Audit Log
Task: "Implement SseBroadcaster using Redis pub/sub"
Task: "Implement GET /auctions/{id}/events SSE stream"

# Developer B: Frontend Dashboard and Controls
Task: "Implement frontend SSE client using StreamProvider"
Task: "Build frontend Auctioneer Panel"
```
