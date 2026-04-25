# Tasks: Crichere Auction Platform

**Input**: Design documents from `/specs/001-crichere-auction-platform/`
**Prerequisites**: plan.md (required), spec.md (required), data-model.md, contracts/api.md

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic directory structure for backend and frontend

- [x] T001 Initialize Spring Boot backend project in `crichere-backend/` with Kotlin DSL
- [x] T002 [P] Initialize Flutter frontend project in `crichere-flutter/`
- [x] T003 [P] Configure backend Flyway and PostgreSQL connection in `crichere-backend/src/main/resources/application.yml`
- [x] T004 [P] Configure frontend Riverpod, Dio, and Drift dependencies in `crichere-flutter/pubspec.yaml`
- [x] T005 [P] Create backend module structure: `domain/<module>/{entity, repository, service, controller, dto}`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core security, authentication, and communication infrastructure

- [x] T006 Implement JWT Authentication Filter and security configuration in `crichere-backend/src/main/kotlin/common/security/`
- [x] T007 [P] Implement `ResponseHelper` and standard error envelope in `crichere-backend/src/main/kotlin/common/response/`
- [x] T008 [P] Implement pluggable `SmsProvider` (MSG91) and `PushProvider` (FCM) interfaces in `crichere-backend/src/main/kotlin/common/provider/`
- [x] T009 Create `User` and `OTP` entities and repositories in `crichere-backend/src/main/kotlin/domain/auth/`
- [x] T010 Implement S3 presigned URL service in `crichere-backend/src/main/kotlin/common/service/S3Service.kt`
- [x] T011 [P] Setup frontend Clean Architecture folders in `crichere-flutter/lib/` (core, features, shared)
- [x] T012 [P] Implement frontend JWT secure storage and Dio interceptors in `crichere-flutter/lib/core/network/`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - League Configuration (Priority: P1)

**Goal**: Enable League Admins to create and configure leagues with full rules and player imports

**Independent Test**: Admin creates a league and imports players via CSV. Verification: League and players appear in backend DB and frontend list.

- [x] T013 [US1] Create `League` and `LeaguePlayer` entities and Flyway migration `V004__create_league_tables.sql`
- [x] T014 [US1] Implement `LeagueService` with status transition logic and base price resolution in `crichere-backend/src/main/kotlin/domain/league/`
- [x] T015 [US1] Implement Bulk CSV Player Import with ghost profile creation in `crichere-backend/src/main/kotlin/domain/league/BulkImportService.kt`
- [x] T016 [US1] Create `LeagueController` with endpoints for creation and config update
- [x] T044 [P] [US1] Unit test `LeagueService` base price resolution logic (FR-012 priority order)
- [x] T017 [P] [US1] Create frontend League feature module (data, domain, presentation) in `crichere-flutter/lib/features/league/`
- [ ] T018 [US1] Implement frontend League creation form and CSV upload logic

---

## Phase 4: User Story 2 - Real-Time Auction (Priority: P1)

**Goal**: Conduct a live auction with real-time SSE updates and auctioneer controls

**Independent Test**: Auctioneer records a bid. Verification: All connected viewers receive the `BidPlaced` SSE event within 500ms.

- [x] T019 [US2] Create `Auction`, `Bid`, and `AuctionAuditLog` entities and Flyway migration `V006__create_auction_tables.sql`
- [x] T020 [US2] Implement `SseBroadcaster` using Redis pub/sub for cross-instance event distribution in `crichere-backend/src/main/kotlin/domain/auction/`
- [x] T021 [US2] Implement `AuctionService` with state machine transitions (DRAFT -> LIVE -> PAUSED)
- [x] T022 [US2] Implement Auctioneer bid recording and "Undo" logic with mandatory reasons
- [x] T023 [US2] Implement `GET /auctions/{id}/events` SSE stream with `Last-Event-ID` replay logic
- [x] T024 [P] [US2] Implement frontend SSE client using `eventsource` and Riverpod `StreamProvider` in `crichere-flutter/lib/features/auction/`
- [/] T025 [P] [US2] Build frontend Auctioneer Panel (Web) with Undo/Force-Assign controls and Viewer Dashboard (Mobile)
- [x] T042 [US2] Implement Player Pre-assignment (Captain/Icon) logic with purse deduction in backend
- [x] T043 [US2] Implement League Admin Force-Assign logic (bypassing purse) in backend and frontend

---

## Phase 5: User Story 3 - Player Registration & Ghost Claiming (Priority: P1)

**Goal**: Allow players to claim their pre-created profiles via OTP verification

**Independent Test**: User enters phone, verifies OTP. Verification: Profile status changes from `GHOST` to `ACTIVE` and `claimedAt` is set.

- [x] T026 [US3] Implement `POST /api/v1/auth/profile/claim` endpoint in `crichere-backend/src/main/kotlin/domain/auth/`
- [x] T027 [US3] Implement logic to auto-link all existing `LeaguePlayer` records to the claiming `User`
- [/] T028 [P] [US3] Create frontend Player feature module in `crichere-flutter/lib/features/player/`
- [/] T029 [US3] Implement frontend Profile Claiming flow (OTP input + Style/Role/Level configuration)

---

## Phase 6: User Story 4 - Fee and Forfeit Management (Priority: P2)

**Goal**: Manage financial obligations and automated waiting list promotions

**Independent Test**: Admin approves a forfeit. Verification: Next player in waiting list is automatically promoted in `AUTO_PROMOTE` mode.

- [x] T030 [US4] Create `FeeObligation`, `ForfeitRequest`, and `WaitingList` entities and Flyway migrations `V007-V011`
- [x] T031 [US4] Implement `ForfeitService` with `feeRefundDecision` rules and `AUTO_PROMOTE` logic
- [x] T032 [US4] Implement `WaitingList` position auto-shifting on promotion or withdrawal
- [x] T033 [US4] Implement backend Fee collection summary reporting
- [/] T034 [P] [US4] Implement frontend Fee and Forfeit management screens in `crichere-flutter/lib/features/fee/`

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Global exports, notifications, and final UI refinements

- [x] T035 [P] Implement backend PDF generation for squad summaries using iText/PDFBox
- [ ] T036 Implement frontend shareable squad image capture using `screenshot` package
- [x] T037 [P] Configure FCM background message handling and backend dispatch timing telemetry (SC-004)
- [ ] T038 Final UI/UX polish: Lottie animations and Shimmer loading states
- [ ] T039 [P] Setup SSE load-test harness (JMeter/Gatling) targeting 5,000 viewers/auction
- [ ] T040 [P] Perform Redis pub/sub benchmark for cross-instance latency validation
- [ ] T041 Validate platform scaling to 50 simultaneous auctions (250k total connections)

---

## Bug-Fix Pass (post-review, 2026-04-25)

**Purpose**: Correctness fixes identified during full spec compliance review.

- [x] T045 Fix OTP: move rate-limit check before expiry mutation; add Indian phone format guard (`^[6-9]\d{9}$`) in `OtpService`
- [x] T046 Fix `AuctionService.pauseAuction` and `resumeAuction` missing status guard (LIVE→PAUSED, PAUSED→LIVE)
- [x] T047 Fix `AuctionService.undoBid` missing explicit `UP_FOR_BIDDING` state assertion (FR-009)
- [x] T048 Fix `AuctionService.preAssign` roundId check — now throws `BusinessLogicException` matching `forceAssign` behaviour
- [x] T049 Add `auctionEligible` guard in `AuctionService.putPlayer` (FR-013 — forfeit deregisters players)
- [x] T050 Add `mustSellAll` enforcement in `AuctionService.completeAuction` (FR-007)
- [x] T051 Convert `League.waitingListMode` from raw String to `WaitingListMode` enum; update `ForfeitService` and `WaitingListService` comparisons
- [x] T052 Expose `waitingListMode` in `LeagueCreateRequest`, `LeagueResponse`, and `LeagueController`; add Flyway `V013__add_league_fields.sql` and `V014__waiting_list_partial_index.sql`
- [x] T053 Handle `DataIntegrityViolationException` in `WaitingListService.addToWaitingList` position race — returns 409 with retryable error key
- [x] T054 Remove dead `leaguePlayerRepository.findAllByUserId` call from `AuthService.claimProfile`; replace with explanatory comment

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
